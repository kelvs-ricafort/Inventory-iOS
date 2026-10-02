//
//  ItemEditViewModel.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class ItemEditViewModel {
    
    private let repository: ItemsRepository
    
    let item: Item
    
    var name: String
    var price: String
    var quantity: String
    
    init(
        item: Item,
        repository: ItemsRepository
    ) {
        self.item = item
        self.repository = repository

        self.name = item.name
        self.price = String(item.price)
        self.quantity = String(item.quantity)
    }
    
    var isValid: Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return false }
        guard let price = Double(price), price >= 0 else { return false }
        guard let quantity = Int(quantity), quantity >= 0 else { return false }
        
        return true
    }
    
    func save() async {
        guard
            let price = Double(price),
            let quantity = Int(quantity) else { return }
        
        item.name = name
        item.price = price
        item.quantity = quantity
        
        await repository.updateItem(item)
    }
}
