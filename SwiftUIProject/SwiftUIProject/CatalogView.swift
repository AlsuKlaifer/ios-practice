//
//  CatalogView.swift
//  SwiftUIProject
//
//  Created by Alsu Faizova on 21.04.2023.
//

import SwiftUI

struct CatalogPage: Identifiable, Hashable {
    var id: Int
}

struct CatalogView: View {
    
    @ObservedObject
    var navigationObject: NavigationObject
    
    var page: Int
    
    var body: some View {
        NavigationStack(path: $navigationObject.path) {
            VStack(spacing: 20) {
                Text("Page: \(page)")
                
                Button {
                    navigationObject.path.append(CatalogPage(id: page))
                } label: {
                    Text("Browse catalog")
                        .frame(width: 200, height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(.systemBlue))
                        )
                        .foregroundColor(.white)
                        .bold()
                }
                
                Button {
                    navigationObject.path = .init()
                } label: {
                    Text("Close all")
                        .frame(width: 200, height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(.systemGray2))
                        )
                        .foregroundColor(.white)
                        .bold()
                }
            }
        }
        .navigationDestination(for: CatalogPage.self) { page in
            CatalogView(navigationObject: navigationObject, page: page.id + 1)
        }
    }
}
