//
//  GeneratorView.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 11/09/2024.
//

import SwiftUI

struct GeneratorView: View {
    @ObservedObject var numberGenerator: RandomNumberGenerator
    @FocusState private var isInputActive: Bool
    @State private var showToast = false
    @State private var toastStyle: ToastStyle = .neutral
    @State private var toastMessage: LocalizedStringKey = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    
                    VStack(spacing: 56) {
                        CounterView(value: numberGenerator.randomInt) { success in
                            if success {
                                showToast(message: "copied_to_clipboard", style: .neutral)
                            } else {
                                showToast(message: "copy_error", style: .error)
                            }
                        }
                        
                        HStack {
                            MinMaxField(titleKey: "min_label", value: $numberGenerator.minValue, isInputActive: _isInputActive)
                            MinMaxField(titleKey: "max_label", value: $numberGenerator.maxValue, isInputActive: _isInputActive)
                        }
                    }
                    .frame(height: geometry.size.height * 0.4)
                    
                    Spacer()
                    
                    GenerateButton {
                        if numberGenerator.minValue > numberGenerator.maxValue {
                            showToast(message: "min_max_error", style: .warning)
                        } else {
                            numberGenerator.generate()
                        }
                    }
                }
                .ignoresSafeArea(.keyboard)
                .padding(16)
            }
            
            ToastView(message: toastMessage, style: toastStyle, isPresented: $showToast)
        }
        .background(Color("primary-bg"))
        .onChange(of: numberGenerator.minValue) { _ in checkMinMaxValues() }
        .onChange(of: numberGenerator.maxValue) { _ in checkMinMaxValues() }
    }
    
    private func showToast(message: LocalizedStringKey, style: ToastStyle) {
        toastMessage = message
        toastStyle = style
        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            showToast = false
        }
    }
    
    private func checkMinMaxValues() {
        if numberGenerator.minValue > numberGenerator.maxValue {
            showToast(message: "min_max_error", style: .warning)
        }
    }
}

#Preview {
        GeneratorView(numberGenerator: RandomNumberGenerator())
    }
