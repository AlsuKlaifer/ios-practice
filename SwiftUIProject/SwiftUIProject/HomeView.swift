//
//  HomeView.swift
//  SwiftUIProject
//
//  Created by Alsu Faizova on 21.04.2023.
//

import SwiftUI

class NavigationObject: ObservableObject {
    @Published
    var path: NavigationPath = .init()
}

struct HomeView: View {
    
    @State
    var showFullScreenModalAnimals: Bool = false
    
    @ObservedObject
    var navigationObject: NavigationObject = .init()
    
    var body: some View {
        NavigationStack(path: $navigationObject.path) {
            VStack(spacing: 15) {
                Button {
                    navigationObject.path.append(CatalogPage(id: 0))
                } label: {
                    Text("Browse catalog")
                        .frame(width: 200, height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemBlue))
                        )
                        .foregroundColor(.white)
                        .bold()
                }
                
                Button {
                    showFullScreenModalAnimals.toggle()
                } label: {
                    Text("Show animal")
                        .frame(width: 200, height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray)
                        )
                        .foregroundColor(.white)
                        .bold()
                    
                        .fullScreenCover(isPresented: $showFullScreenModalAnimals) {
                            AnimalView(showFullScreenModal: $showFullScreenModalAnimals)
                        }
                }
            }
            .navigationDestination(for: CatalogPage.self) { page in
                CatalogView(navigationObject: navigationObject, page: page.id + 1)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
