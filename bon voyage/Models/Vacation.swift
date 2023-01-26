//
//  Vacation.swift
//  bon voyage
//
//  Created by HardiBSalih on 16.01.2023.
//

import Foundation

struct Vacation {
    let price : Int
    let description: String
    let title: String
    let images: [String]
    let activities: String
    let airFare: String
    let numberOfDays: Int

    init(price: Int, description: String, title: String, images: [String], activities: String, airFare: String, numberOfDays: Int) {
        self.price = price
        self.description = description
        self.title = title
        self.images = images
        self.activities = activities
        self.airFare = airFare
        self.numberOfDays = numberOfDays
    }
    
    init(data: [String: Any]) {
        price = data["price"] as? Int ?? 0
        description = data["description"] as? String ?? ""
        title = data["title"] as? String ?? ""
        images = data["images"] as? [String] ?? [String]()
        activities = data["activities"] as? String ?? ""
        airFare = data["airFare"] as? String ?? ""
        numberOfDays = data["numberOfDays"] as? Int ?? 0
    }
}
