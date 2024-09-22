import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    @AppStorage("selectedNumberFormat") private var selectedNumberFormat: NumberFormat = .comma
    @AppStorage("selectedLanguage") private var selectedLanguage: CustomAppLanguage = .system
    @State private var showingNumberFormatSheet = false
    
    private let feedbackFormURL = URL(string: "https://forms.gle/9eQohXKThryjPeJs8")!
    private let bugReportURL = URL(string: "https://forms.gle/NuSpjCvWz9HF4zit6")!
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("primary-bg").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 40) {
                        ThemeSelector(selectedTheme: $selectedTheme)
                            .padding(.horizontal)
                        
                        generalSection
                        
                        supportSection
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle(Text("settings_title"))
            .sheet(isPresented: $showingNumberFormatSheet) {
                NumberFormatBottomSheet(selectedFormat: $selectedNumberFormat, isPresented: $showingNumberFormatSheet)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
        .preferredColorScheme(colorScheme)
        .languageResponsive()
        .id(selectedLanguage) // Force view to rebuild when language changes
    }
    
    private var generalSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("general_section_title")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(Color("primary_DarkMode"))
            
            VStack(spacing: 0) {
                Button(action: {
                    showingNumberFormatSheet = true
                }) {
                    HStack {
                        Text("number_format_label")
                            .foregroundColor(Color("primary_DarkMode"))
                        Spacer()
                        Text(LocalizedStringKey(selectedNumberFormat.rawValue))
                            .foregroundColor(Color("secondary_DarkMode"))
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 16)

                }
                
                LanguageSelector(selectedLanguage: $selectedLanguage)
            }
            .background(Color("surface-settings-bg"))
            .cornerRadius(16)
        }
        .padding(.horizontal)
    }
    
    private var supportSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("support_section_title")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(Color("primary_DarkMode"))
            
            VStack(spacing: 0) {
                FeedbackLinkView(url: feedbackFormURL, titleKey: "feedback_link_title", iconName: "arrow.up.right")
                FeedbackLinkView(url: bugReportURL, titleKey: "report_bug_link_title", iconName: "arrow.up.right")
            }
            .background(Color("surface-settings-bg"))
            .cornerRadius(16)
            
        }
        .padding(.horizontal)
    }
    
    private var colorScheme: ColorScheme? {
        switch selectedTheme {
        case .light: return .light
        case .dark: return .dark
        case .system: return nil
        }
    }
}


#Preview {
    SettingsView()
}
