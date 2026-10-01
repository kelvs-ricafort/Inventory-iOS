//
//  PreviewData.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import Foundation

enum PreviewData {
    static let items: [Item] = [
        Item(id: 1, name: "Game", price: 100.0, quantity: 20),
        Item(id: 2, name: "Pen", price: 200.0, quantity: 30),
        Item(id: 3, name: "TV", price: 300.0, quantity: 50)
    ]
    static let item = items[0]
    
    static let emptyItems: [Item] = []
}
