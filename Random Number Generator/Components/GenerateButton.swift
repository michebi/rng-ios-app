//
//  GenerateButton.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 07/06/2024.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                RoundedRectangle(cornerRadius: 360)
                    .fill(Color("primary_DarkMode"))
            )
            .scaleEffect(configuration.isPressed ? CGSize(width: 0.95, height: 0.95) : CGSize(width: 1, height: 1))
            .animation(.spring(response: 2, dampingFraction: 0.9, blendDuration: 2), value: configuration.isPressed)
    }
}

struct GenerateButton: View {
    var action: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isPressed = false
                action()
            }
        }, label: {
            Text("generate_button", comment: "")
                .fontWeight(.medium)
                .frame(width: .infinity, height: 64, alignment: .center)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color("primary_LightMode"))
                .font(.system(size: 18))
                .contentShape(RoundedRectangle(cornerRadius: 16))
        })
        .buttonStyle(CustomButtonStyle())
        .scaleEffect(isPressed ? CGSize(width: 0.95, height: 0.95) : CGSize(width: 1, height: 1))
        .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0), value: isPressed)
    }
}

#Preview {
        GenerateButton(action: {})
    }
