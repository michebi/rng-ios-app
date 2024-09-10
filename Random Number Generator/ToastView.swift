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
}

struct ToastView: View {
    let message: String
    let style: ToastStyle
    @Binding var isPresented: Bool
    
    private var backgroundColor: Color {
        switch style {
        case .success:
            return Color("success-bg")
        case .error:
            return Color("danger-bg")
        case .neutral:
            return Color("neutral-bg")
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
        }
    }
    
    private var icon: String {
        switch style {
        case .success, .neutral:
            return "checkmark.circle"
        case .error:
            return "exclamationmark.circle"
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(textColor)
            
            Text(message)
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
    VStack {
        ToastView(message: "Success message!", style: .success, isPresented: .constant(true))
        Spacer()
        ToastView(message: "Error message!", style: .error, isPresented: .constant(true))
        Spacer()
        ToastView(message: "Neutral message!", style: .neutral, isPresented: .constant(true))
    }
    .background(Color.gray.opacity(0.3))
}
