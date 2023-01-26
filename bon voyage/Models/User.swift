//
//  User.swift
//  bon voyage
//
//  Created by HardiBSalih on 18.01.2023.
//

import Foundation

struct User {
    var id: String
    var stripeId: String
    var email: String
    
    static func initFrom( _ data: [String: Any]) -> User {
        let id = data["id"] as? String ?? ""
        let stripeId = data["stripeId"] as? String ?? ""
        let email = data["email"] as? String ?? ""
        
        return User(id: id, stripeId: stripeId, email: email)
    }
}
