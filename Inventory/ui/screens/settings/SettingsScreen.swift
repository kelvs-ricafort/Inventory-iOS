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
            Section {
                Picker("Language", selection: $settings.language) {
                    ForEach(AppLanguage.allCases) { language in
                        HStack {
                            Text(language.flag)
                            Text(language.displayName)
                        }
                        .tag(language)
                    }
                }
            } header: {
                Text("Language")
            }
            
            Section {
                Toggle("Dark Mode", isOn: $settings.darkMode)
            } header: {
                Text("Appearance")
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    let settings = AppSettings()
    NavigationStack {
        SettingsScreen()
    }
    .environment(settings)
}
