//
//  Random_Number_GeneratorApp.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 09/02/2023.
//

import SwiftUI

@main

struct Random_Number_GeneratorApp: App {
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
