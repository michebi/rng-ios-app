//
//  FeedbackLinkView.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 21/09/2024.
//

import SwiftUI

struct FeedbackLinkView: View {
    let url: URL
    let titleKey: LocalizedStringKey
    let iconName: String
    @State private var showingWebView = false

    var body: some View {
        Button(action: {
            showingWebView = true
        }) {
            HStack {
                Text(titleKey)
                    .foregroundColor(Color("primary_DarkMode"))
                Spacer()
                Image(systemName: iconName)
                    .foregroundColor(Color("secondary_DarkMode"))
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
            .background(Color("surface-settings-bg"))
            .cornerRadius(10)
        }
        .sheet(isPresented: $showingWebView) {
            WebFormView(url: url, titleKey: titleKey)
        }
    }
}
