//
//  CheckoutVC.swift
//  bon voyage
//
//  Created by HardiBSalih on 16.01.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFunctions
import Stripe

class CheckoutVC: UIViewController {
    
    @IBOutlet weak var vacationTitle: UILabel!
    @IBOutlet weak var airFairLbl: UILabel!
    @IBOutlet weak var numberOfNightLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var selectCardView: UIView!
    @IBOutlet weak var CardImage: UIImageView!
    @IBOutlet weak var endingCardLbl: UILabel!
    @IBOutlet weak var selectBankView: UIView!
    @IBOutlet weak var bankImage: UIImageView!
    @IBOutlet weak var endingBankLbl: UILabel!
    @IBOutlet weak var packagePriceLbl: UILabel!
    @IBOutlet weak var procesingFeeLbl: UILabel!
    @IBOutlet weak var totalPaymentLbl: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var vacation: Vacation!
    var currentSelectedPaymentType: PaymentType?
    var paymentContext : STPPaymentContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTapGestures()
        setUpUI()
        setCheckoutLableDetails()
        setUpCardUI()
        setUpStripe()
        
    }
    
    func setCheckoutLableDetails() {
        let proccessingFees = (FeeCalculator.calculateFeesForCard(subtotal: vacation.price))
        let total = proccessingFees + vacation.price
        packagePriceLbl.text = "Package Price: " + vacation.price.formatIntToString()
        procesingFeeLbl.text = "Processing Fees: \(proccessingFees.formatIntToString())"
        totalPaymentLbl.text = "Total: " + total.formatIntToString()
    }
    
    func setUpUI(){
        vacationTitle.text = vacation.title
        airFairLbl.text = vacation.airFare
        numberOfNightLbl.text = "\(vacation.numberOfDays) night accomodations"
        priceLbl.text = "All inclusive price: " + vacation.price.formatIntToString()
    }
    
    func setUpTapGestures(){
        let selectCardTouch = UITapGestureRecognizer(target: self, action: #selector(selectCardTapped))
        selectCardView.addGestureRecognizer(selectCardTouch)
        let selectBankTouch = UITapGestureRecognizer(target: self, action: #selector(selectBankTapped))
        selectBankView.addGestureRecognizer(selectBankTouch)
    }
    
    // MARK: Select Card
    @objc func selectCardTapped(){
        setUpCardUI()
    }
    
    // MARK: Select Bank
    @objc func selectBankTapped(){
        setUpBankUI()
    }
    
    func setUpCardUI(){
        if currentSelectedPaymentType == .card  { return }
        
        currentSelectedPaymentType = .card
        selectCardView.layer.cornerRadius = 10
        selectCardView.layer.borderColor = UIColor(named: Constants.BorderBlue)?.cgColor
        selectCardView.layer.borderWidth = 2
        
        selectBankView.layer.cornerRadius = 10
        selectBankView.layer.borderColor = UIColor.lightGray.cgColor
        selectBankView.layer.borderWidth = 1
        
        CardImage.tintColor = UIColor(named: Constants.BorderBlue)
        bankImage.tintColor = UIColor.lightGray
    }
    func setUpBankUI(){
        if currentSelectedPaymentType == .bank  { return }
        
        currentSelectedPaymentType = .bank
        selectBankView.layer.cornerRadius = 10
        selectBankView.layer.borderColor = UIColor(named: Constants.BorderBlue)?.cgColor
        selectBankView.layer.borderWidth = 2
        
        selectCardView.layer.cornerRadius = 10
        selectCardView.layer.borderColor = UIColor.lightGray.cgColor
        selectCardView.layer.borderWidth = 1
        
        bankImage.tintColor = UIColor(named: Constants.BorderBlue)
        CardImage.tintColor = UIColor.lightGray
    }
    
    
    @IBAction func changeCardClicked(_ sender: Any) {
        paymentContext.pushPaymentOptionsViewController()
    }
    
    @IBAction func changeBankClicked(_ sender: Any) {
    }
    
    
    @IBAction func checkoutClicked(_ sender: Any) {
        let total = vacation.price + FeeCalculator.calculateFeesForCard(subtotal: vacation.price)
        let confirmPayment = UIAlertController(title: "Confirm Payment", message: "Confirm payment for \(total.formatToDecimalCurrencyString())", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
            self.indicator.startAnimating()
            self.paymentContext.requestPayment()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        confirmPayment.addAction(confirmAction)
        confirmPayment.addAction(cancel)
        present(confirmPayment, animated: true)
    }
    
    func setUpStripe(){
        guard (UserService.instance.user?.stripeId) != nil else { return }
        let config = STPPaymentConfiguration.shared
        paymentContext = STPPaymentContext(customerContext: Wallet.instance.customerContext, configuration: config, theme: .defaultTheme)
        paymentContext.hostViewController = self
        paymentContext.delegate = self
    }
    
}

// MARK: Stripe Delegate Psudeo Code
extension CheckoutVC : STPPaymentContextDelegate {
    // MARK: Payment Context Changed
    func paymentContextDidChange(_ paymentContext: Stripe.STPPaymentContext) {
        // Triggers when the content of the payment context changes, like when the user selects a new payment method or enters shipping information.
        if let card = paymentContext.selectedPaymentOption {
            endingCardLbl.text = card.label
        }else {
            endingCardLbl.text = "No Card Selected"
        }
    }
    
    func paymentContext(_ paymentContext: Stripe.STPPaymentContext, didFailToLoadWithError error: Error) {
        simpleAlert(msg: "Sorry, but we are not able to load you credit cards at this time.")
    }
    
    // MARK: Create Payment Intent
    func paymentContext(_ paymentContext: Stripe.STPPaymentContext, didCreatePaymentResult paymentResult: Stripe.STPPaymentResult, completion: @escaping StripePayments.STPPaymentStatusBlock) {
        
        let idempotency = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        let fees = FeeCalculator.calculateFeesForCard(subtotal: vacation.price)
        let total = vacation.price + fees
        
        let json: [String: Any] = [
            "total": total,
            "idempotency": idempotency,
            "customer_id": UserService.instance.stripeId
        ]
        
        
        Functions.functions().httpsCallable("createPaymentIntent").call(json) { result, error in
            if let error = error {
                debugPrint(error)
                self.simpleAlert(msg: "Sorry, but we are not able to complete your payment")
                return
            }
            
            // Request Stripe payment intent, and return client secret.
            guard let clientSecret = result?.data as? String else {
                return
            }
            
            // The client secret can be used to complete a payment from your frontend.
            // Once the client secret is obtained, create paymentIntentParams
            let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
            paymentIntentParams.paymentMethodId = paymentResult.paymentMethod?.stripeId
            
            // Confirm the PaymentIntent
            STPPaymentHandler.shared().confirmPayment(paymentIntentParams, with: paymentContext) { status, paymentIntent, error in
                switch status {
                case .succeeded:
                    completion(.success, nil)
                case .failed:
                    completion(.error, error)
                case .canceled:
                    completion(.userCancellation, nil)
                @unknown default:
                    completion(.error, nil)
                }
            }
            
        }
    }
    
    // MARK: DId Finish Payment
    func paymentContext(_ paymentContext: Stripe.STPPaymentContext, didFinishWith status: StripePayments.STPPaymentStatus, error: Error?) {
        // Take action based on return status: error, success, userCancellation
        switch status {
        case .error:
            simpleAlert(msg: "Sorry, something went wrong during checkout. You were not charged and can try again.")
        case .success:
            let successAlert = UIAlertController(title: "Payment Success!", message: "\nYou will receive an email with all the travel details soon! \n\n Bon Voyage!", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            successAlert.addAction(ok)
            present(successAlert, animated: true)
            
            let newMail : [String: Any] = [
                "to": UserService.instance.user?.email ?? "",
                "message" : [
                    "subject" : "Your Vacation Awaits",
                    "text": "Description : \(vacation.description)"
                ]
            ]
            
            Firestore.firestore().collection("mail").addDocument(data: newMail)
            
            
            
            
            
            
        case .userCancellation:
            return
        default:
            break
        }
    }
    
    
}







enum PaymentType {
    case card
    case bank
}
