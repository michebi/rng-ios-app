import SwiftUI

enum AppTheme: Int {
    case system = 0
    case light = 1
    case dark = 2
}

struct ThemeSelector: View {
    @Binding var selectedTheme: AppTheme
    @Environment(\.customAppLanguage) var customAppLanguage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("theme_label")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(Color("primary_DarkMode"))
            
            HStack(spacing: 16) {
                themeOption(theme: .system)
                themeOption(theme: .light, bgColor: "theme-bg-light", fgColor: "theme-fg-light")
                themeOption(theme: .dark, bgColor: "theme-bg-dark", fgColor: "theme-fg-dark")
            }
        }
        .id(customAppLanguage) // This forces a re-render when the language changes
    }
    
    private func themeOption(theme: AppTheme, bgColor: String? = nil, fgColor: String? = nil) -> some View {
        VStack(alignment: .center, spacing: 12) {
            if theme == .system {
                systemThemeOption
            } else {
                themeOptionView(theme: theme, bgColor: bgColor!, fgColor: fgColor!)
            }
            
            Text(localizedKey(for: theme))
                .font(.system(size: 14))
                .foregroundColor(Color("secondary_DarkMode"))
        }
        .frame(maxWidth: .infinity)
    }
    
    private func localizedKey(for theme: AppTheme) -> LocalizedStringKey {
        switch theme {
        case .system:
            return "system_theme"
        case .light:
            return "light_theme"
        case .dark:
            return "dark_theme"
        }
    }
    
    private var systemThemeOption: some View {
        themeOptionCard(theme: .system) {
            VStack(spacing: 0) {
                // Light mode half
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color("theme-fg-light"))
                        .frame(width: UIScreen.main.bounds.width * 0.08)
                    
                    VStack(spacing: 4) {
                        ForEach(0..<3) { _ in
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("theme-fg-light"))
                                .frame(height: 6)
                        }
                    }
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity)
                }
                .frame(height: 40)
                
                // Dark mode half
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color("theme-fg-dark"))
                        .frame(width: UIScreen.main.bounds.width * 0.08)
                    
                    VStack(spacing: 4) {
                        ForEach(0..<3) { _ in
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("theme-fg-dark"))
                                .frame(height: 6)
                        }
                    }
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity)
                }
                .frame(height: 40)
                .background(Color("theme-bg-dark"))
            }
        }
    }
    
    private func themeOptionView(theme: AppTheme, bgColor: String, fgColor: String) -> some View {
        themeOptionCard(theme: theme) {
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color(fgColor))
                    .frame(width: UIScreen.main.bounds.width * 0.08)
                
                VStack(spacing: 8) {
                    ForEach(0..<3) { _ in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(fgColor))
                            .frame(height: 8)
                    }
                }
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity)
            }
            .frame(height: 80)
            .background(Color(bgColor))
        }
    }
    
    private func themeOptionCard<Content: View>(theme: AppTheme, @ViewBuilder content: @escaping () -> Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("theme-bg-light"))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedTheme == theme ? Color("brand-border") : Color("primary-border"), lineWidth: selectedTheme == theme ? 2 : 1)
                )
            
            content()
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .frame(height: 80)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("brand-focus"), lineWidth: selectedTheme == theme ? 8 : 0)
                .padding(-1)
        )
        .onTapGesture {
            selectedTheme = theme
        }
    }
}

struct ThemeSelector_Previews: PreviewProvider {
    static var previews: some View {
        ThemeSelector(selectedTheme: .constant(.system))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
