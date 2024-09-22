//
//  EmptyStateView.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 11/09/2024.
//

import SwiftUI

struct EmptyStateView: View {
    @ObservedObject var numberGenerator: RandomNumberGenerator
    
    var body: some View {
        VStack(spacing: 8) {
            Text("empty_history_title")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color("primary_DarkMode"))
            
            Text("empty_history_message")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(Color("secondary_DarkMode"))
                .multilineTextAlignment(.center)
        }
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(numberGenerator: RandomNumberGenerator())
    }
}
