//
//  WebFormView.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 21/09/2024.
//

import SwiftUI

struct WebFormView: View {
    @Environment(\.presentationMode) var presentationMode
    let url: URL
    let titleKey: LocalizedStringKey

    var body: some View {
        NavigationView {
            WebView(url: url)
                .navigationBarTitle(Text(titleKey), displayMode: .inline)
                .navigationBarItems(trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                })
        }
    }
}
