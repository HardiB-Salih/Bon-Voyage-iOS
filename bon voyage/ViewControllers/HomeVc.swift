//
//  ViewController.swift
//  bon voyage
//
//  Created by HardiBSalih on 16.01.2023.
//

import UIKit

class HomeVc: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var vacations = [Vacation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        vacations = demoData
        
        title = "Vecation Packeges"
        let loginVC = LoginRegisterVC()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
        
        setUpTableView()
    }
    
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.contentInset.top = 8
        tableView.register(UINib(nibName: "VacationCell", bundle: nil), forCellReuseIdentifier: "VacationCell")
    }

    @IBAction func userIconClicked(_ sender: Any) {
        let userSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let logout = UIAlertAction(title: "Logout", style: .default) { (action) in
                //Logout
        }
        let manageCard = UIAlertAction(title: "Manage Crdit Card", style: .default) { (action) in
                //Manage Crdit Card
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
    
}

extension HomeVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VacationCell", for: indexPath) as! VacationCell
        cell.confugerCell(vacation: vacations[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    
    
}
