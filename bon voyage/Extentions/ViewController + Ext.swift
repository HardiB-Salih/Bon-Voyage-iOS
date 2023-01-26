//
//  ViewController + Ext.swift
//  bon voyage
//
//  Created by HardiBSalih on 17.01.2023.
//

import UIKit

extension UIViewController {
    
    func simpleAlert(title: String? = "Error", msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
        
    }
}
