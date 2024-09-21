//
//  MinMaxField.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 07/06/2024.
//

import SwiftUI

struct MinMaxField: View {
    let titleKey: LocalizedStringKey
    @Binding var value: Int
    @FocusState var isInputActive: Bool
    @AppStorage("selectedNumberFormat") private var selectedNumberFormat: NumberFormat = .comma
    
    @State private var formattedValue: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Text(titleKey)
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
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if let newIntValue = Int(filtered) {
                        value = newIntValue
                        formattedValue = formatNumber(newIntValue, format: selectedNumberFormat)
                    } else if filtered.isEmpty {
                        value = 0
                        formattedValue = "0"
                    }
                }
                .onAppear {
                    formattedValue = formatNumber(value, format: selectedNumberFormat)
                }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    isInputActive = false
                } label: {
                    Text("done_button")
                        .font(.system(size: 16, weight: .medium))
                }
            }
        }
    }
}

struct MinMaxField_Previews: PreviewProvider {
    @State static private var value: Int = 1000
    @FocusState static private var isInputActive: Bool
    
    static var previews: some View {
        MinMaxField(titleKey: "Preview", value: $value, isInputActive: _isInputActive)
    }
}
