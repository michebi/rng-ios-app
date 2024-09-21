import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @StateObject private var numberGenerator = RandomNumberGenerator()
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    @AppStorage("selectedLanguage") private var selectedLanguage: CustomAppLanguage = .system
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                GeneratorView(numberGenerator: numberGenerator)
                    .tag(0)
                HistoryView(numberGenerator: numberGenerator)
                    .tag(1)
                SettingsView()
                    .tag(2)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
        .preferredColorScheme(colorScheme)
        .environment(\.locale, Locale(identifier: selectedLanguage == .system ? Locale.current.identifier : selectedLanguage.rawValue))
    }
    
    private var colorScheme: ColorScheme? {
        switch selectedTheme {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color("primary-border"))
                .frame(height: 1)
            
            HStack {
                TabBarButton(
                    imageName: "number.circle",
                    titleKey: "tab_generator",
                    isSelected: selectedTab == 0,
                    action: { selectedTab = 0 }
                )
                TabBarButton(
                    imageName: "clock",
                    titleKey: "tab_history",
                    isSelected: selectedTab == 1,
                    action: { selectedTab = 1 }
                )
                TabBarButton(
                    imageName: "gearshape",
                    titleKey: "tab_settings",
                    isSelected: selectedTab == 2,
                    action: { selectedTab = 2 }
                )
            }
            .padding(.top, 8)
            .padding(.bottom, 20)
        }
        .background(Color("primary-bg").ignoresSafeArea(edges: .bottom))
    }
}

struct TabBarButton: View {
    let imageName: String
    let titleKey: LocalizedStringKey
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: isSelected ? imageName + ".fill" : imageName)
                    .font(.system(size: 24))
                Text(titleKey)
                    .font(.system(size: 12))
            }
            .foregroundColor(isSelected ? Color("primary_DarkMode") : Color("secondary_DarkMode"))
            .frame(maxWidth: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
