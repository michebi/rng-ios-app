//
//  MinMaxField.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 07/06/2024.
//

import SwiftUI

struct MinMaxField: View {
    let title: String
    @Binding var value: Int
    @FocusState var isInputActive: Bool
    
    @State private var formattedValue: String = ""
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("secondary_LightMode"))
            TextField("0", text: $formattedValue)
                .keyboardType(.numberPad)
                .focused($isInputActive)
                .multilineTextAlignment(.center)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.system(size: 24))
                .onChange(of: formattedValue) { newValue in
                    let filtered = newValue.filter { "0123456789,".contains($0) }
                    let numericValue = filtered.replacingOccurrences(of: ",", with: "")
                    
                    if numericValue.count <= 12 {
                        if let newIntValue = Int(numericValue) {
                            value = newIntValue
                            if let formatted = numberFormatter.string(from: NSNumber(value: newIntValue)) {
                                formattedValue = formatted
                            }
                        } else if filtered.isEmpty {
                            value = 0
                            formattedValue = "0"
                        }
                    } else {
                        // If exceeds 12 digits, revert to the previous valid value
                        formattedValue = numberFormatter.string(from: NSNumber(value: value)) ?? "0"
                    }
                }
                .onAppear {
                    formattedValue = numberFormatter.string(from: NSNumber(value: value)) ?? "0"
                }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isInputActive = false
                }
                .font(.system(size: 16, weight: .medium))
            }
        }
    }
}

struct MinMaxField_Previews: PreviewProvider {
    @State static private var value: Int = 1000
    @FocusState static private var isInputActive: Bool
    
    static var previews: some View {
        MinMaxField(title: "Preview", value: $value, isInputActive: _isInputActive)
    }
}
