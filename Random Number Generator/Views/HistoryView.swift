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
    @AppStorage("selectedLanguage") private var selectedLanguage: CustomAppLanguage = .system
    
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
                    Text("clear_all_button")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(numberGenerator.history.isEmpty ? Color("primary-disabled") : Color("primary-link"))
                }
                .disabled(numberGenerator.history.isEmpty)
            )
            .alert(isPresented: $showingClearConfirmation) {
                Alert(
                    title: Text("clear_confirmation_title"),
                    message: Text("clear_confirmation_message"),
                    primaryButton: .destructive(Text("clear_action")) {
                        numberGenerator.clearHistory()
                    },
                    secondaryButton: .cancel(Text("cancel_action"))
                )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .languageResponsive()
        .id(selectedLanguage) // Force view to rebuild when language changes
    }
}

#Preview {
    HistoryView(numberGenerator: RandomNumberGenerator())
}
