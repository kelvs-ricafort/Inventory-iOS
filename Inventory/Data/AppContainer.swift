//
//  AppContainer.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import Foundation

protocol AppContainer {
    var itemsRepository: ItemsRepository { get }
}

final class AppDataContainer: AppContainer {
    let itemsRepository: ItemsRepository
    
    init() {
        self.itemsRepository = OfflineItemsRepository(items: PreviewData.items)
    }
}
