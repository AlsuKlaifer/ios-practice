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
    
    @State
    var showFullScreenModalMain: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
                .frame(height: 50)
            
            TextField("Login", text: $login)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .frame(height: 35)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 10))
                .background(.white)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1.0)
                )
            
            SecureField("Password", text: $password)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .frame(height: 35)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 10))
                .background(.white)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1.0)
                )
            
            let right = login == "admin" && password == "1234"
            
            Button {
                if right {
                    showFullScreenModalMain.toggle()
                } else {
                    showAlert = true
                }
            } label: {
                Text("Sign in")
                    .frame(width: 200, height: 45)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.linearGradient(colors: [Color(.systemGray), Color(.systemGray3)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    )
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(.top, 10)
            .alert("Error", isPresented: $showAlert) {
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
            } message: {
                Text("Try again")
            }
            .fullScreenCover(isPresented: $showFullScreenModalMain) {
                VStack {
                    TabView {
                        HomeView()
                            .tabItem {
                                Label("Home", systemImage: "house")
                            }
                        
                        ProfileView(name: login, showFullScreenModal: $showFullScreenModalMain)
                            .tabItem {
                                Label("Profile", systemImage: "person")
                            }
                    }
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
