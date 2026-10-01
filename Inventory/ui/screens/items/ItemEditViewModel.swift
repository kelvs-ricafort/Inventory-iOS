//
//  ItemEditViewModel.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import Foundation
import Observation

@Observable
final class ItemEditViewModel {
    
    private let repository: ItemsRepository
    
    let itemID: Int
    
    var name: String
    var price: String
    var quantity: String
    
    init(
        item: Item,
        repository: ItemsRepository
    ) {
        self.repository = repository
        self.itemID = item.id
        self.name = item.name
        self.price = String(item.price)
        self.quantity = String(item.quantity)
    }
    
    var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        Double(price) != nil &&
        Int(quantity) != nil
    }
    
    func save() async {
        guard
            let price = Double(price),
            let quantity = Int(quantity)
                else {
            return
        }
        
        let item = Item(
            id: itemID,
            name: name,
            price: price,
            quantity: quantity
        )
        
        await repository.updateItem(item)
    }
}
