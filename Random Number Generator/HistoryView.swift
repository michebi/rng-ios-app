//
//  HistoryView.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 11/09/2024.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var numberGenerator: RandomNumberGenerator
    @State private var showingClearConfirmation = false
    @Environment(\.customAppLanguage) var customAppLanguage
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("primary-bg").edgesIgnoringSafeArea(.all)
                
                if numberGenerator.history.isEmpty {
                    EmptyStateView(numberGenerator: numberGenerator)
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            ForEach(numberGenerator.history) { item in
                                HistoryListItem(item: item)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle(Text("history_title"))
            .navigationBarItems(trailing:
                Button(action: {
                    showingClearConfirmation = true
                }) {
                    Text("clear_all_button", comment: "")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(numberGenerator.history.isEmpty ? Color("primary-disabled") : Color("primary-link"))
                }
                .disabled(numberGenerator.history.isEmpty)
            )
            .alert(isPresented: $showingClearConfirmation) {
                Alert(
                    title: Text("clear_confirmation_title", comment: ""),
                    message: Text("clear_confirmation_message", comment: ""),
                    primaryButton: .destructive(Text("clear_action", comment: "")) {
                        numberGenerator.clearHistory()
                    },
                    secondaryButton: .cancel(Text("cancel_action", comment: ""))
                )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .id(customAppLanguage)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(numberGenerator: RandomNumberGenerator())
    }
}
