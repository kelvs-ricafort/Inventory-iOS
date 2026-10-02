//
//  AppContainer.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import SwiftData

protocol AppContainer {
    var modelContainer: ModelContainer { get }
    var itemsRepository: ItemsRepository { get }
}

@MainActor
final class AppDataContainer: AppContainer {
    
    let modelContainer: ModelContainer
    let itemsRepository: ItemsRepository
    
    init(inMemory: Bool = false) {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            
            modelContainer = try ModelContainer(for: Item.self, configurations: configuration)
            
            itemsRepository = OfflineItemsRepository(modelContext: modelContainer.mainContext)
        } catch {
            fatalError("Failed to create SwiftData ModelContainer: \(error)")
        }
    }
}
