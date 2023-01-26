//
//  LoginRegisterVC.swift
//  bon voyage
//
//  Created by HardiBSalih on 16.01.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFunctions
import FirebaseFirestore

class LoginRegisterVC: UIViewController {

    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    @IBOutlet weak var registerEmail: UITextField!
    @IBOutlet weak var registerPassword: UITextField!
    @IBOutlet weak var registerPasswordConfig: UITextField!
    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    lazy var functions = Functions.functions()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtnClicked(_ sender: Any) {
        guard let email = loginEmail.text , email.isNotEmpty,
              let password = loginPassword.text , password.isNotEmpty else {
            
            simpleAlert(msg: "Please fill in all required fields.")
            return
        }
        
        progressBar.startAnimating()
        
        Auth.auth().signIn(withEmail: email, password: password) {(result, err) in
            
            defer {
                self.progressBar.stopAnimating()
            }
            
            if let err = err {
                self.simpleAlert(msg: err.localizedDescription)
                return
            }
            
            self.dismiss(animated: true)
        }
    }
    @IBAction func registerBtnClicked(_ sender: Any) {
        guard let email = registerEmail.text , email.isNotEmpty,
              let password = registerPassword.text , password.isNotEmpty,
              let confirmPassword = registerPasswordConfig.text , confirmPassword.isNotEmpty else {
            
            simpleAlert(msg: "Please fill in all required fields.")
            return
        }
        
        if password != confirmPassword {
            simpleAlert(msg: "Your password not match please try again.")
            return
        }
        progressBar.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) {(result, err) in
            
            defer {
                self.progressBar.stopAnimating()
            }
            
            if let err = err {
                self.simpleAlert(msg: err.localizedDescription)
                return
            }
            
            let log : [String: Any] = [
                "msg": "new user registered",
                "timestamp": Timestamp()
            ]
            
            Firestore.firestore().collection("logs").addDocument(data: log) { err in
                if let err = err {
                    print(err.localizedDescription)
                }else {
                    print("Logs Successfully added")
                }
            }
            
            
            // call it: createStripeUser
            self.functions.httpsCallable("createStripeUser").call(["email": email]) { (result, error) in
                if let error = error {
                    self.simpleAlert(msg: error.localizedDescription)
                    debugPrint(error.localizedDescription)
                    return
                }
                self.dismiss(animated: true)
            }
        }
    }
}
