//
//  LanguageResponsiveModifier.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 22/09/2024.
//

import SwiftUI

struct LanguageResponsive: ViewModifier {
    @AppStorage("selectedLanguage") var selectedLanguage: CustomAppLanguage = .system
    
    func body(content: Content) -> some View {
        content
            .id(selectedLanguage) // Force view to update when language changes
            .environment(\.locale, Locale(identifier: selectedLanguage == .system ? Locale.current.identifier : selectedLanguage.rawValue))
    }
}

extension View {
    func languageResponsive() -> some View {
        modifier(LanguageResponsive())
    }
}
