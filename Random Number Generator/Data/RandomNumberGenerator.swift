//
//  NumberGen.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 07/06/2024.
//

import Foundation

struct HistoryItem: Identifiable, Codable {
    let id: UUID
    let number: Int
    let minValue: Int
    let maxValue: Int
    let timestamp: Date
    
    init(number: Int, minValue: Int, maxValue: Int, timestamp: Date) {
        self.id = UUID()
        self.number = number
        self.minValue = minValue
        self.maxValue = maxValue
        self.timestamp = timestamp
    }
}

class RandomNumberGenerator: ObservableObject {
    @Published var minValue: Int {
        didSet {
            UserDefaults.standard.set(minValue, forKey: "minValue")
        }
    }
    @Published var maxValue: Int {
        didSet {
            UserDefaults.standard.set(maxValue, forKey: "maxValue")
        }
    }
    @Published var randomInt: Int = 0
    @Published var history: [HistoryItem] = [] {
        didSet {
            saveHistory()
        }
    }
    
    init() {
        self.minValue = UserDefaults.standard.integer(forKey: "minValue")
        self.maxValue = UserDefaults.standard.integer(forKey: "maxValue")
        
        // If it's the first launch and no values are stored, set default values
        if self.minValue == 0 && self.maxValue == 0 {
            self.minValue = 1
            self.maxValue = 100
            UserDefaults.standard.set(self.minValue, forKey: "minValue")
            UserDefaults.standard.set(self.maxValue, forKey: "maxValue")
        }
        
        loadHistory()
    }
    
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
    
    private func saveHistory() {
        do {
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(history)
            UserDefaults.standard.set(encoded, forKey: "history")
        } catch {
            print("Failed to save history: \(error.localizedDescription)")
        }
    }
    
    private func loadHistory() {
        guard let savedHistory = UserDefaults.standard.data(forKey: "history") else { return }
        do {
            let decoder = JSONDecoder()
            history = try decoder.decode([HistoryItem].self, from: savedHistory)
        } catch {
            print("Failed to load history: \(error.localizedDescription)")
        }
    }
}
