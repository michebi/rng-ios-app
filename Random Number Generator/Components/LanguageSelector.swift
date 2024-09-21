import SwiftUI

struct LanguageSelector: View {
    @Binding var selectedLanguage: CustomAppLanguage
    @State private var showingLanguageSheet = false
    
    var body: some View {
        Button(action: {
            showingLanguageSheet = true
        }) {
            HStack {
                Text(NSLocalizedString("language_selection_title", comment: "Language selection title"))
                    .foregroundColor(Color("primary_DarkMode"))
                Spacer()
                Text(selectedLanguage.displayName)
                    .foregroundColor(Color("secondary_DarkMode"))
            }
            .padding()
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
            List(CustomAppLanguage.allCases) { language in
                Button(action: {
                    selectedLanguage = language
                    isPresented = false
                }) {
                    HStack {
                        Text(language.displayName)
                        Spacer()
                        if language == selectedLanguage {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle(Text("language_selection_title", comment: "Language selection title"))
            .navigationBarItems(trailing: Button("Done") {
                isPresented = false
            })
        }
    }
}
