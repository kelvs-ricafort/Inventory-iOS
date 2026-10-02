//
//  AppSettings.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 10/2/26.
//

import SwiftUI
import Observation

@Observable
@MainActor
final class AppSettings {
    var language: AppLanguage {
        didSet {
            UserDefaults.standard.set(language.rawValue, forKey: "appLanguage")
        }
    }
    
    var darkMode: Bool {
        didSet {
            UserDefaults.standard.set(darkMode, forKey: "darkMode")
        }
    }
    
    init() {
        let savedLanguage = UserDefaults.standard.string(forKey: "appLanguage") ?? AppLanguage.english.rawValue
        
        language = AppLanguage(rawValue: savedLanguage) ?? .english
        
        darkMode = UserDefaults.standard.bool(forKey: "darkMode")
    }
}


enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case filipino = "fil"
    case spanish = "es"
    
    var id: String { rawValue }
    
    var locale: Locale { Locale(identifier: rawValue) }
    
    var displayName: String {
        switch self {
        case .english:
            return "English"
        case .filipino:
            return "Filipino"
        case .spanish:
            return "Español"
        }
    }
    
    var flag: String {
        switch self {
        case .english:
            return "🇺🇸"
        case .filipino:
            return "🇵🇭"
        case .spanish:
            return "🇪🇸"
        }
    }
}
