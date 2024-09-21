//
//  HistoryListItem.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 11/09/2024.
//

import SwiftUI

struct HistoryListItem: View {
    let item: HistoryItem
    @AppStorage("selectedNumberFormat") private var selectedNumberFormat: NumberFormat = .comma
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(formatNumber(item.number, format: selectedNumberFormat))
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(Color("primary_DarkMode"))
            
            Text("\(formatNumber(item.minValue, format: selectedNumberFormat)) - \(formatNumber(item.maxValue, format: selectedNumberFormat))")
                .font(.system(size: 14))
                .foregroundColor(Color("secondary_DarkMode"))
        }
        .padding(.vertical, 24)
    }
}

struct HistoryListItem_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("primary-bg").edgesIgnoringSafeArea(.all)  // Add this to simulate the app's background
            HistoryListItem(item: HistoryItem(number: 42, minValue: 1, maxValue: 100, timestamp: Date()))
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
