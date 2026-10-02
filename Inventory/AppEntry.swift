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
    @State private var settings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            MainView(container: container)
                .environment(settings)
                .environment(\.locale, settings.language.locale)
                .preferredColorScheme(settings.darkMode ? .dark: .light)
        }
        .modelContainer(container.modelContainer)
    }
}
