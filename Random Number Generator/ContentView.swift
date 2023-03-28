//
//  ContentView.swift
//  Random Number Generator
//
//  Created by Michael Ebimomi on 09/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State var minTextField: String = ""
    @State var maxTextField: String = ""
    @State var randomInt = Int.random(in: 0...0)
    @State private var minimumValue: String = ""
    @State private var maximumValue: String = ""
    @State private var generatedValue: Int?
    
    // Saves the dark mode theme for the user
    @AppStorage("IsDarkMode") private var isDark = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color("primary_LightMode")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // This is the generated number text
                    Text("\(randomInt)")
                        .font(.system(size: 56))
                        .multilineTextAlignment(.center)
                        .padding(.top, 120)
                    
                    Spacer()
                        .frame(height: 110)
                    
                    HStack {
                        VStack(alignment: .center) {
                            
                            // Input field to change the RNG values
                            Text("MIN")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("secondary_LightMode"))
                            TextField("0", text: $minTextField)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .textFieldStyle(PlainTextFieldStyle())
                                .font(.system(size: 24))
                                .onChange(of: minTextField) { newValue in
                                    if newValue.count > 9 {
                                        minTextField = String(newValue.prefix(9))
                                    }
                                }
                        }
                        
                        VStack(alignment: .center) {
                            
                            // Input field to change the RNG values
                            Text("MAX")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("secondary_LightMode"))
                            TextField("0", text: $maxTextField)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .textFieldStyle(PlainTextFieldStyle())
                                .font(.system(size: 24))
                                .onChange(of: maxTextField) { newValue in
                                    if newValue.count > 9 {
                                        maxTextField = String(newValue.prefix(9))
                                    }
                                }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 240)
                    
                    // Button instance to generate new number
                    
                    Button("Generate", action: {
                        if minTextField.isEmpty || maxTextField.isEmpty {
                            return
                        }
                        let min = Int(minTextField) ?? 0
                        let max = Int(maxTextField) ?? 100
                        randomInt = Int.random(in: min...max)
                    })
                    .contentShape(RoundedRectangle(cornerRadius: 360))
                    .fixedSize()
                    .frame(width: 286, height: 36, alignment: .center)
                    .frame(maxWidth: .infinity)
                    .padding(16.0)
                    .foregroundColor(Color("primary_LightMode"))
                    .background(Color("primary_DarkMode"))
                    .cornerRadius(360)
                    .font(.system(size: 16))
                    
                }
                .padding(16.0)
                .navigationTitle("")
                
                // The tool bar above the app
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { isDark.toggle() }) {
                            if isDark {
                                Label("Dark", systemImage: "sun.max.fill")
                                    .font(.title)
                                    .foregroundColor(Color("primary_DarkMode"))
                            } else {
                                Label("Light", systemImage: "moon.fill")
                                    .font(.title)
                                    .foregroundColor(Color("primary_DarkMode"))
                            }
                        }
                    }
                }
            }
            .environment(\.colorScheme, isDark ? .dark : .light)
        }
    }
    
    
    
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
