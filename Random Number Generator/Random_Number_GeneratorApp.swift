//
//  Random_Number_GeneratorApp.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 09/02/2023.
//

import SwiftUI

@main
struct Random_Number_GeneratorApp: App {
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(colorScheme)
        }
    }
    
    private var colorScheme: ColorScheme? {
        switch selectedTheme {
        case .light: return .light
        case .dark: return .dark
        case .system: return nil
        }
    }
}

