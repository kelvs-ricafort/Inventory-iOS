//
//  ItemEntryViewModel.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class ItemEntryViewModel {
    
    var name = ""
    var price = ""
    var quantity = ""

    private let repository: ItemsRepository

    init(repository: ItemsRepository) {
        self.repository = repository
    }

    var isValid: Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return false }
        guard let price = Double(price), price >= 0 else { return false }
        guard let quantity = Int(quantity), quantity >= 0 else { return false }

        return true
    }

    func save() async {
        guard let price = Double(price), let quantity = Int(quantity) else { return }
        
        let existingItems = await repository.getAllItems()
        let nextID = (existingItems.map(\.id).max() ?? 0) + 1

        let item = Item(
            id: nextID,
            name: name,
            price: price,
            quantity: quantity
        )

        await repository.insertItem(item)
    }
}
