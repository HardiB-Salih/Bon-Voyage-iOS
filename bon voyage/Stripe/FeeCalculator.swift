//
//  FeeCalculator.swift
//  bon voyage
//
//  Created by HardiBSalih on 18.01.2023.
//

import Foundation

class FeeCalculator {
    private static let strpeCriditCardCut = 0.029
    private static let flatFeeCut = 30

    static func calculateFeesForCard(subtotal: Int) -> Int {
        if subtotal == 0 {
            return 0
        }
        
        let fees = Int(Double(subtotal) * strpeCriditCardCut) + flatFeeCut
        return fees
    }
}
