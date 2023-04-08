//
//  ContentView.swift
//  SwiftUIProject
//
//  Created by Alsu Faizova on 04.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State
    var login: String = ""

    @State
    var password: String = ""
    
    @State
    var showAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
                .frame(height: 50)
            
            TextField(" Login", text: $login)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            SecureField(" Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            
            let right = login == "admin" && password == "1234"
            
            Button {
                showAlert = true
            } label: {
                Text("Sign in")
                    .frame(width: 200, height: 45)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.linearGradient(colors: [Color(.systemGray2), Color(.systemGray3)], startPoint: .top, endPoint: .bottomTrailing))
                    )
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(.top, 10)
            .alert("\(right ? "Congratulations" : "Error")", isPresented: $showAlert) {
                if right {
                    Button("OK") {}
                } else {
                    Button("Clear login") {
                        login = ""
                    }
                    Button("Clear password") {
                        password = ""
                    }
                    Button("Clear all") {
                        login = ""
                        password = ""
                    }
                }
            } message: {
                if (right) {
                    Text("You successfully logged in")
                } else {
                    Text("Try again")
                }
            }

            
            Spacer()
        }
        .padding(.horizontal, 30)
        .background(Color(.systemGray6))
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
