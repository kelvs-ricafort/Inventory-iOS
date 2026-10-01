//
//  ItemDetailsViewModel.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import Foundation
import Observation

@Observable
final class ItemDetailsViewModel {

    private let repository: ItemsRepository

    var item: Item

    init(
        item: Item,
        repository: ItemsRepository
    ) {
        self.item = item
        self.repository = repository
    }

    func sellItem() async {
        guard item.quantity > 0 else { return }
        item.quantity -= 1

        await repository.updateItem(item)
    }

    func deleteItem() async {
        await repository.deleteItem(item)
    }
}
