//
//  OfflineItemsRepository.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import Foundation

final class OfflineItemsRepository: ItemsRepository {
    private var items: [Item]
    
    init(items: [Item] = []) {
        self.items = items
    }
    
    func getAllItems() async -> [Item] {
            items
    }

    func getItem(id: Int) async -> Item? {
        items.first { $0.id == id }
    }

    func insertItem(_ item: Item) async {
        items.append(item)
    }

    func updateItem(_ item: Item) async {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }

        items[index] = item
    }

    func deleteItem(_ item: Item) async {
        await deleteItem(id: item.id)
    }

    func deleteItem(id: Int) async {
        items.removeAll { $0.id == id }
    }
}
