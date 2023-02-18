//
//  LoginPresenter.swift
//  OnlineShop
//
//  Created by Alsu Faizova on 11.02.2023.
//

import Foundation

class LoginPresenter {
    var authorizationService: AuthorizationService = MockAuthorizationService.shared
    
    weak var view: LoginViewController?
    
    @MainActor
    func logIn(login: String, password: String){
        view?.showLoader()
        Task{
            do{
                try await authorizationService.signIn(login: login, password: password)
                await MainActor.run {
                    view?.hideLoader()
                }
            } catch {
                view?.show(error: error)
            }
        }
    }
    
}
