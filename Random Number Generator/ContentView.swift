//
//  ContentView.swift
//  Layout
//
//  Created by Michael Ebimomi on 22/06/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var numberGenerator = RandomNumberGenerator()
    @State private var minValue: Int = 1
    @State private var maxValue: Int = 100
    @FocusState private var isInputActive: Bool
    @State private var showToast = false
    @State private var toastStyle: ToastStyle = .neutral
    @State private var toastMessage = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    
                    VStack(spacing: 56) {
                        CounterView(value: numberGenerator.randomInt) {
                            showToast(message: "Copied to clipboard", style: .neutral)
                        }
                        
                        HStack {
                            MinMaxField(title: "Min", value: $minValue, isInputActive: _isInputActive)
                            MinMaxField(title: "Max", value: $maxValue, isInputActive: _isInputActive)
                        }
                    }
                    .frame(height: geometry.size.height * 0.4)
                    
                    Spacer()
                    
                    GenerateButton {
                        numberGenerator.minValue = minValue
                        numberGenerator.maxValue = maxValue
                        numberGenerator.generate()
                        if numberGenerator.randomInt == 0 {
                            showToast(message: "Generated number is 0!", style: .error)
                        }
                    }
                }
                .ignoresSafeArea(.keyboard)
                .padding(16)
            }
            
            ToastView(message: toastMessage, style: toastStyle, isPresented: $showToast)
        }
        .background(Color("primary-bg"))
    }
    
    private func showToast(message: String, style: ToastStyle) {
        toastMessage = message
        toastStyle = style
        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            showToast = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
