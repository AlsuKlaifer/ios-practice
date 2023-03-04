//
//  RestAuthorizationService.swift
//  OnlineShop
//
//  Created by Alsu Faizova on 03.03.2023.
//

import Foundation
import Combine

class RestAuthorizationService: AuthorizationService {
    static let shared: MockAuthorizationService = .init()

    private var _isAuthorized: CurrentValueSubject<Bool, Never> = .init(false)

    var isAuthorized: AnyPublisher<Bool, Never> { _isAuthorized
        .removeDuplicates()
        .eraseToAnyPublisher()
    }
    
    
    func signIn(login: String, password: String) async throws {
        try? await Task.sleep(for: .seconds(1))
        if !(login == "admin" && password == "123") {
            _isAuthorized.value = false
            throw AuthorizationError.unauthorized
        } else {
            _isAuthorized.value = true
        }
    }
    
    func confirmSignIn() async {
        _isAuthorized.value = true
    }

    func signOut() {
        _isAuthorized.value = false
    }
}
