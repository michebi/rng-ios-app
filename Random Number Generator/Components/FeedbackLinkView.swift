//
//  FeedbackLinkView.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 21/09/2024.
//

import SwiftUI

struct FeedbackLinkView: View {
    let url: URL
    
    var body: some View {
        Link(destination: url) {
            HStack {
                Text("feedback_link_title")
                    .foregroundColor(Color("primary_DarkMode"))
                Spacer()
                Image(systemName: "arrow.up.right")
                    .foregroundColor(Color("secondary_DarkMode"))
            }
            .padding()
            .background(Color("surface-settings-bg"))
            .cornerRadius(10)
        }
    }
}

#Preview {
    FeedbackLinkView(url: URL(string: "https://forms.gle/vjTvJC2haTuTFHjt9")!)
        .previewLayout(.sizeThatFits)
        .padding()
}
