//
//  ItemsRepository.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import Foundation

protocol ItemsRepository {
    func getAllItems() async -> [Item]
    func getItem(id: Int) async -> Item?
    func insertItem(_ item: Item) async
    func updateItem(_ item: Item) async
    func deleteItem(_ item: Item) async
    func deleteItem(id: Int) async
}
