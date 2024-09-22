//
//  NumberFormat.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 14/09/2024.
//

import Foundation
import SwiftUI

enum NumberFormat: String, CaseIterable, Identifiable {
    case comma = "number_format_commas"
    case period = "number_format_period"
    case space = "number_format_space"
    case apostrophe = "number_format_apostrophe"
    
    var id: String { self.rawValue }
    
    func format(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = self.separator
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    var separator: String {
        switch self {
        case .comma: return ","
        case .period: return "."
        case .space: return " "
        case .apostrophe: return "'"
        }
    }
    
    var example: String {
        self.format(10000)
    }
    
    var localizedKey: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
}

func formatNumber(_ number: Int, format: NumberFormat) -> String {
    return format.format(number)
}
