//
//  AnimalView.swift
//  SwiftUIProject
//
//  Created by Alsu Faizova on 21.04.2023.
//

import SwiftUI

struct AnimalView: View {
    
    @Binding
    var showFullScreenModal: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Image("animal")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                .frame(width: 300, height: 400)
            Button {
                showFullScreenModal.toggle()
            } label: {
                Text("Close")
                    .frame(width: 200, height: 45)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemGray))
                    )
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}
