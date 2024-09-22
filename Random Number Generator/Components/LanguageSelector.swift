import SwiftUI

struct LanguageSelector: View {
    @Binding var selectedLanguage: CustomAppLanguage
    @State private var showingLanguageSheet = false
    
    var body: some View {
        Button(action: {
            showingLanguageSheet = true
        }) {
            HStack {
                Text("language_selection_title")
                    .foregroundColor(Color("primary_DarkMode"))
                Spacer()
                Text(selectedLanguage.displayName)
                    .foregroundColor(Color("secondary_DarkMode"))
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
        }
        .background(Color("surface-settings-bg"))
        .cornerRadius(16)
        .sheet(isPresented: $showingLanguageSheet) {
            LanguageSelectionSheet(selectedLanguage: $selectedLanguage, isPresented: $showingLanguageSheet)
        }
    }
}

struct LanguageSelectionSheet: View {
    @Binding var selectedLanguage: CustomAppLanguage
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                ScrollView {
                    VStack(spacing: 24) {
                        ForEach(CustomAppLanguage.allCases) { language in
                            Button(action: {
                                selectedLanguage = language
                                isPresented = false
                            }) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(language.displayName)
                                            .font(.system(size: 20))
                                            .foregroundColor(Color("primary_DarkMode"))
                                        Text(language.englishName)
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(Color("secondary_DarkMode"))
                                    }
                                    Spacer()
                                    if language == selectedLanguage {
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
                }
            }
            .navigationTitle(Text("language_selection_title"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") {
                isPresented = false
            })
        }
    }
}

extension CustomAppLanguage {
    var englishName: String {
        switch self {
        case .system: return "System Language"
        case .english: return "English"
        case .french: return "French"
        case .german: return "German"
        case .italian: return "Italian"
        case .korean: return "Korean"
        case .norwegian: return "Norwegian"
        case .polish: return "Polish"
        case .spanish: return "Spanish"
        case .vietnamese: return "Vietnamese"
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        LanguageSelector(selectedLanguage: .constant(.english))
        LanguageSelector(selectedLanguage: .constant(.french))
        LanguageSelector(selectedLanguage: .constant(.korean))
    }
    .padding()
    .preferredColorScheme(.dark)
    .background(Color("primary-bg"))
}

#Preview("Language Selection Sheet") {
    LanguageSelectionSheet(selectedLanguage: .constant(.english), isPresented: .constant(true))
        .preferredColorScheme(.dark)
}
