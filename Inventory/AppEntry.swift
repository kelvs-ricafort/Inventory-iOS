//
//  AppEntry.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/29/26.
//

import SwiftUI

@main
struct AppEntry: App {
    private let container: AppContainer
    
    init() {
        container = AppDataContainer()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(container: container)
        }
    }
}
