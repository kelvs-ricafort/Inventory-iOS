//
//  Item.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    @Attribute(.unique)
    var id: Int
    var name: String
    var price: Double
    var quantity: Int
    var createdAt: Date
    
    init(id: Int = 0, name: String, price: Double, quantity: Int, createdAt: Date = .now) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
        self.createdAt = createdAt
    }
    
    var isOutOfStock: Bool {
        quantity <= 0
    }
}
