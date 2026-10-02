//
//  HomeViewModel.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import Foundation
import Observation

@Observable
final class HomeViewModel {
    private let repository: ItemsRepository
    
    private(set) var items: [Item] = []
    private(set) var refreshId = UUID()
    
    init(repository: ItemsRepository) {
        self.repository = repository
    }
    
    func loadItems() async {
        items = await repository.getAllItems()
        refreshId = UUID()
    }
}
