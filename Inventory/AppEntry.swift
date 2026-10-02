//
//  AppEntry.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/29/26.
//

import SwiftUI
import SwiftData

@main
struct AppEntry: App {
    private let container = AppDataContainer()
    
    var body: some Scene {
        WindowGroup {
            MainView(container: container)
        }
        .modelContainer(container.modelContainer)
    }
}
