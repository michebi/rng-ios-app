//
//  ToastView.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 10/09/2024.
//

import SwiftUI

enum ToastStyle {
    case success
    case error
    case neutral
    case warning
}

struct ToastView: View {
    let message: Text
    let style: ToastStyle
    @Binding var isPresented: Bool
    
    init(message: String, style: ToastStyle, isPresented: Binding<Bool>) {
        self.message = Text(message)
        self.style = style
        self._isPresented = isPresented
    }
    
    init(message: LocalizedStringKey, style: ToastStyle, isPresented: Binding<Bool>) {
        self.message = Text(message)
        self.style = style
        self._isPresented = isPresented
    }
    
    private var backgroundColor: Color {
        switch style {
        case .success:
            return Color("success-bg")
        case .error:
            return Color("danger-bg")
        case .neutral:
            return Color("neutral-bg")
        case .warning:
            return Color("warning-bg")
        }
    }
    
    private var textColor: Color {
        switch style {
        case .success:
            return Color("success-text")
        case .error:
            return Color("danger-text")
        case .neutral:
            return Color("neutral-text")
        case .warning:
            return Color("warning-text")
        }
    }
    
    private var icon: String {
        switch style {
        case .success, .neutral:
            return "checkmark.circle"
        case .error, .warning:
            return "exclamationmark.circle"
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(textColor)
            
            message
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(textColor)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
        .background(backgroundColor)
        .cornerRadius(360)
        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .opacity(isPresented ? 1.0 : 0.0)
        .scaleEffect(isPresented ? 1.0 : 0.8)
        .animation(.easeInOut(duration: 0.3), value: isPresented)
    }
}

#Preview {
    VStack(spacing: 20) {
        ToastView(message: "Success message!", style: .success, isPresented: .constant(true))
        ToastView(message: "Error message!", style: .error, isPresented: .constant(true))
        ToastView(message: "Neutral message!", style: .neutral, isPresented: .constant(true))
        ToastView(message: "Warning message!", style: .warning, isPresented: .constant(true))
    }
    .padding()
    .background(Color.gray.opacity(0.2))
}
