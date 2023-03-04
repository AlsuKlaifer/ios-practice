//
//  MockLoginView.swift
//  OnlineShopTests
//
//  Created by Alsu Faizova on 03.03.2023.
//

import Foundation
@testable import OnlineShop

class MockLoginView: LoginView {
    
    var showLoaderIsCalled: Bool = false
    var hideLoaderIsCalled: Bool = false
    var showError: Error?
    
    func showLoader() {
        showLoaderIsCalled = true
    }
    
    func hideLoader() {
        hideLoaderIsCalled = true
    }
    
    func show(error: Error) {
        showError = error
    }
    
}
