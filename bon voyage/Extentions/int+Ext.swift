//
//  int+Ext.swift
//  bon voyage
//
//  Created by HardiBSalih on 16.01.2023.
//

import Foundation

extension Int {
    func formatIntToString() -> String {
        let formater = NumberFormatter()
        formater.numberStyle = .currency
        formater.maximumFractionDigits = 0
        
        let nsNum = NSNumber(integerLiteral: self / 100)
        return formater.string(from: nsNum) ?? "$$$"
    }
    
    func formatToDecimalCurrencyString() -> String {
        let formater = NumberFormatter()
        formater.numberStyle = .currency
        formater.maximumFractionDigits = 2
        
        let nsNum = NSNumber(integerLiteral: self / 100)
        return formater.string(from: nsNum) ?? "$$$"
    }
}
