//
//  NumberGen.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 07/06/2024.
//

import Foundation

struct HistoryItem: Identifiable {
    let id = UUID()
    let number: Int
    let minValue: Int
    let maxValue: Int
    let timestamp: Date
}

class RandomNumberGenerator: ObservableObject {
    @Published var minValue: Int = 1
    @Published var maxValue: Int = 100
    @Published var randomInt: Int = 0
    @Published var history: [HistoryItem] = []
    
    func generate() {
        randomInt = Int.random(in: minValue...maxValue)
        addToHistory(HistoryItem(number: randomInt, minValue: minValue, maxValue: maxValue, timestamp: Date()))
    }
    
    private func addToHistory(_ item: HistoryItem) {
        history.insert(item, at: 0)
        if history.count > 50 {
            history.removeLast()
        }
    }
    
    func clearHistory() {
        history.removeAll()
    }
}
