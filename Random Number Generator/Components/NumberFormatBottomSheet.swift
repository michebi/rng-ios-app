//
//  NumberFormatBottomSheet.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 22/09/2024.
//

import SwiftUI

struct NumberFormatBottomSheet: View {
    @Binding var selectedFormat: NumberFormat
    @Binding var isPresented: Bool
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 12) {
            Text("number_format_label")
                .font(.system(size: 18, weight: .semibold))
                .padding(.top, 32.0)
                .frame(maxWidth: .infinity, alignment: .center)
            
            VStack(alignment: .leading, spacing: 24) {
                ForEach(NumberFormat.allCases) { format in
                    Button(action: {
                        selectedFormat = format
                        isPresented = false
                    }) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(LocalizedStringKey(format.rawValue))
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color("primary_\(colorScheme == .dark ? "DarkMode" : "LightMode")"))
                                Text(format.example)
                                    .font(.system(size: 28))
                                    .foregroundColor(Color("primary_\(colorScheme == .dark ? "DarkMode" : "LightMode")"))
                            }
                            Spacer()
                            if format == selectedFormat {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
            
            Spacer()
        }
    }
}
#Preview {
    NumberFormatBottomSheet(selectedFormat: .constant(.comma), isPresented: .constant(true))
}
