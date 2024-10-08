//
//  AppLanguage.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 20/09/2024.
//

import SwiftUI

enum CustomAppLanguage: String, CaseIterable, Identifiable {
    case system = "system"
    case english = "en"
    case french = "fr"
    case german = "de"
    case italian = "it"
    case korean = "ko"
    case norwegian = "nb"
    case polish = "pl"
    case spanish = "es"
    case vietnamese = "vi"
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .system: return NSLocalizedString("system_language", comment: "")
        case .english: return "English"
        case .french: return "Français"
        case .german: return "Deutsch"
        case .italian: return "Italiano"
        case .korean: return "한국어"
        case .norwegian: return "Norsk"
        case .polish: return "Polski"
        case .spanish: return "Español"
        case .vietnamese: return "Tiếng Việt"
        }
    }
}

// Environment key for CustomAppLanguage
struct CustomAppLanguageKey: EnvironmentKey {
    static let defaultValue: CustomAppLanguage = .system
}

extension EnvironmentValues {
    var customAppLanguage: CustomAppLanguage {
        get { self[CustomAppLanguageKey.self] }
        set { self[CustomAppLanguageKey.self] = newValue }
    }
}
