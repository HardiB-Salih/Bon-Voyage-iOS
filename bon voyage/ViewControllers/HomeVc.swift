//
//  ViewController.swift
//  bon voyage
//
//  Created by HardiBSalih on 16.01.2023.
//

import UIKit
import FirebaseAuth
import Stripe

class HomeVc: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var vacations = [Vacation]()
    var selectedVacation: Vacation!
    
    var paymentContext : STPPaymentContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vacations = demoData
        title = "Vecation Packeges"
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener { auth, user in
            
            if user == nil {
                let loginVC = LoginRegisterVC()
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true)
            } else {
                UserService.instance.getCurrentUser {
                    self.setUpStripe()
                }
            }
        }
    }
    
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.contentInset.top = 8
        tableView.register(UINib(nibName: Constants.VacationCell, bundle: nil), forCellReuseIdentifier: Constants.VacationCell)
    }

    @IBAction func userIconClicked(_ sender: Any) {
        let userSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let logout = UIAlertAction(title: "Logout", style: .default) { (action) in
            do {
                try Auth.auth().signOut()
            } catch {
                debugPrint(error.localizedDescription)
            }
            
            
            
        }
        let manageCard = UIAlertAction(title: "Manage Crdit Card", style: .default) { (action) in
                //Manage Crdit Card
            self.paymentContext.pushPaymentOptionsViewController()
        }
        let manageBank = UIAlertAction(title: "Manage Bank Account", style: .default) { (action) in
                //Manage Crdit Card
        }
        let close = UIAlertAction(title: "close", style: .cancel)
        
        userSheet.addAction(manageCard)
        userSheet.addAction(manageBank)
        userSheet.addAction(logout)
        userSheet.addAction(close)
        
        present(userSheet, animated: true)

        
        
    }
    
    func setUpStripe(){
        Wallet.instance.customerContext = STPCustomerContext(keyProvider: StripeApiClient())
        
        let config = STPPaymentConfiguration.shared
        paymentContext = STPPaymentContext(customerContext: Wallet.instance.customerContext, configuration: config, theme: .defaultTheme)
        paymentContext.hostViewController = self
    }
    
}

extension HomeVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VacationCell, for: indexPath) as! VacationCell
        cell.confugerCell(vacation: vacations[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVacation = vacations[indexPath.row]
        performSegue(withIdentifier: Constants.ToVacationDetail, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destanation = segue.destination as! VacationDetailVC
        destanation.vacation = selectedVacation
    }
    
}
