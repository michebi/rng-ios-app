//
//  FeedbackFormView.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 21/09/2024.
//

import SwiftUI

struct FeedbackFormView: View {
    @Environment(\.presentationMode) var presentationMode
    let url: URL

    var body: some View {
        NavigationView {
            WebView(url: url)
                .navigationBarTitle(Text("feedback_form_title"), displayMode: .inline)
                .navigationBarItems(trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                })
        }
    }
}
