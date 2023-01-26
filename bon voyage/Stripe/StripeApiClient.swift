//
//  StripeApiClient.swift
//  bon voyage
//
//  Created by HardiBSalih on 18.01.2023.
//

import Foundation
import Stripe
import FirebaseFunctions

class StripeApiClient : NSObject, STPCustomerEphemeralKeyProvider {
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping StripePayments.STPJSONResponseCompletionBlock) {
        
        let data = [
            "stripe_version": apiVersion,
            "customer_id": UserService.instance.user?.stripeId
        ]
        
        Functions.functions().httpsCallable("createEphemeralKey").call(data) { result, error in
            if let error = error {
                debugPrint(error)
                return completion(nil, error)
            }
            guard let json = result?.data as? [String: Any] else {
                return completion(nil, nil)
            }
            completion(json, nil)
        }
    }
}
