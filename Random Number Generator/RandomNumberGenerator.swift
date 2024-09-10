//
//  NumberGen.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 07/06/2024.
//

import Foundation

class RandomNumberGenerator: ObservableObject {
    @Published var minValue: Int = 1
    @Published var maxValue: Int = 100
    @Published var randomInt: Int = 0
    
    func generate() {
        randomInt = Int.random(in: minValue...maxValue)
    }
}
