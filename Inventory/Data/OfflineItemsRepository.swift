//
//  OfflineItemsRepository.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import Foundation
import SwiftData

@MainActor
final class OfflineItemsRepository: ItemsRepository {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func getAllItems() async -> [Item] {
        do {
            let descriptor = FetchDescriptor<Item>(
                sortBy: [
                    SortDescriptor(\.createdAt, order: .reverse)
                ]
            )
            
            return try modelContext.fetch(descriptor)
        } catch {
            print("Failed to fetch items: \(error)")
            return []
        }
    }
    
    func getItem(id: Int) async -> Item? {
        do {
            let descriptor = FetchDescriptor<Item>(
                predicate: #Predicate { item in
                    item.id == id
                }
            )
            
            return try modelContext.fetch(descriptor).first
        } catch {
            print("Failed to fetch item: \(error)")
            return nil
        }
    }
    
    func insertItem(_ item: Item) async {
        modelContext.insert(item)
        save()
    }
    
    func updateItem(_ item: Item) async {
        save()
    }
    
    func deleteItem(_ item: Item) async {
        modelContext.delete(item)
        save()
    }
    
    func deleteItem(id: Int) async {
        guard let item = await getItem(id: id) else {
            return
        }
        
        modelContext.delete(item)
        save()
    }
    
    private func save() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save items: \(error)")
        }
    }
}
