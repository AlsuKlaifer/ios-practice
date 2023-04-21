//
//  ProfileView.swift
//  SwiftUIProject
//
//  Created by Alsu Faizova on 21.04.2023.
//

import SwiftUI

struct ProfileView: View {
    var name: String
    
    @Binding
    var showFullScreenModal: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Hello, \(name)!")
                .bold()
            
            Button {
                showFullScreenModal.toggle()
            } label: {
                Text("Sign out")
                    .frame(width: 200, height: 45)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(.systemGray))
                    )
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}
