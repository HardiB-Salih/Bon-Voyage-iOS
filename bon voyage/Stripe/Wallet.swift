//
//  Wallet.swift
//  bon voyage
//
//  Created by HardiBSalih on 18.01.2023.
//

import Foundation
import Stripe

class Wallet {
    
    static let instance = Wallet()
    private init() { }
    
    var customerContext : STPCustomerContext!
}
