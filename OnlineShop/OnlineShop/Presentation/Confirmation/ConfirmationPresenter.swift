//
//  ConfirmationPresenter.swift
//  OnlineShop
//
//  Created by Alsu Faizova on 03.03.2023.
//

import Foundation

class ConfirmationPresenter {
    init(authorizationService: AuthorizationService) {
        self.authorizationService = authorizationService
    }
    
    private let authorizationService: AuthorizationService
    
    func confirm() {
        Task {
            await authorizationService.confirmSignIn()
        }
    }
}
