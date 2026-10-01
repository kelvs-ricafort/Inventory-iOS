//
//  Item.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import Foundation

struct Item: Identifiable, Equatable, Hashable {
    let id: Int
    var name: String
    var price: Double
    var quantity: Int
    
    init(id: Int = 0, name: String, price: Double, quantity: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
    }
    
    var isOutOfStock: Bool {
        quantity <= 0
    }
}
