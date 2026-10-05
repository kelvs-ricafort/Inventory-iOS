//
//  SettingsScreen.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 10/2/26.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(AppSettings.self) private var settings
    
    var body: some View {
        @Bindable var settings = settings
        
        Form {
            Section("Language") {
                Picker("Language", selection: $settings.language) {
                    ForEach(AppLanguage.allCases) { language in
                        Text("\(language.flag) \(language.displayName)")
                            .tag(language)
                    }
                }
            }
            
            Section("Appearance") {
                Toggle("Dark Mode", isOn: $settings.darkMode)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let settings = AppSettings()
    NavigationStack {
        SettingsScreen()
    }
    .environment(settings)
}
