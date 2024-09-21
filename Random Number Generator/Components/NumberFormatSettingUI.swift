import SwiftUI

struct NumberFormatSettingUI: View {
    @Binding var selectedFormat: NumberFormat
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            Text("number_format_label", comment: "")
                .font(.system(size: 18, weight: .semibold))
                .padding(.top, 32.0)
                .frame(maxWidth: .infinity, alignment: .center)
            
            VStack(alignment: .leading, spacing: 24) {
                ForEach(NumberFormat.allCases) { format in
                    Button(action: {
                        selectedFormat = format
                        isPresented = false
                    }) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(format.rawValue)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color("primary_DarkMode"))
                                Text(format.example)
                                    .font(.system(size: 28))
                                    .foregroundColor(Color("primary_DarkMode"))
                            }
                            Spacer()
                            if format == selectedFormat {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())  // This makes the entire HStack tappable
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

struct NumberFormatSettingUI_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var selectedFormat: NumberFormat = .comma
        @State private var isPresented: Bool = true
        
        var body: some View {
            NumberFormatSettingUI(selectedFormat: $selectedFormat, isPresented: $isPresented)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
