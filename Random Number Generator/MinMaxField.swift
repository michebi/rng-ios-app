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
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("secondary_LightMode"))
            TextField("0", value: $value, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .focused($isInputActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isInputActive = false
                        }
                        .font(.system(size: 16, weight: .medium))
                    }
                }
                .multilineTextAlignment(.center)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.system(size: 24))
        }
    }
}

struct MinMaxField_Previews: PreviewProvider {
    @State static private var value: Int = 0
    @FocusState static private var isInputActive: Bool
    
    static var previews: some View {
        MinMaxField(title: "Preview", value: $value, isInputActive: _isInputActive)
    }
}
