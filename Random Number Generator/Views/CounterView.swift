//
//  CounterView.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 07/06/2024.
//

import SwiftUI

struct CounterView: View {
    let value: Int
    @State private var animatedValue: Int = 0
    @State private var isPressed: Bool = false
    @State private var isCopied: Bool = false
    @AppStorage("selectedNumberFormat") private var selectedNumberFormat: NumberFormat = .comma
    var onCopy: (Bool) -> Void
    
    var body: some View {
        ZStack {
            // Placeholder text
            Text("0")
                .font(.system(size: 56))
                .foregroundColor(Color("secondary_DarkMode"))
                .opacity(animatedValue == 0 ? 1.0 : 0.0)
            
            // Actual value
            Text(formatNumber(animatedValue, format: selectedNumberFormat))
                .font(.system(size: 56))
                .contentTransition(.numericText())
                .multilineTextAlignment(.center)
                .opacity(animatedValue == 0 ? 0.0 : 1.0)
                .foregroundColor(Color("primary_DarkMode"))
        }
        .scaleEffect(isPressed && !isCopied ? 0.9 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0), value: isPressed)
        .animation(.easeInOut(duration: 0.2), value: animatedValue)
        .onChange(of: value) { newValue in
            if newValue != 0 {
                animatedValue = newValue
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !isPressed {
                        isPressed = true
                        isCopied = false
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            if isPressed {
                                copyNumber()
                            }
                        }
                    }
                }
                .onEnded { _ in
                    isPressed = false
                    if !isCopied {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
                            isPressed = false
                        }
                    }
                }
        )
    }
    
    private func copyNumber() {
        do {
            try UIPasteboard.general.setItems([["public.plain-text": formatNumber(value, format: selectedNumberFormat)]], options: [:])
            isCopied = true
            isPressed = false
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            onCopy(true)
        } catch {
            print("Failed to copy: \(error)")
            isCopied = false
            isPressed = false
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            onCopy(false)
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(value: 42, onCopy: { _ in })
    }
}
