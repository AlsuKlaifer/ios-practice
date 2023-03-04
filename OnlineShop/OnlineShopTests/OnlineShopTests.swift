//
//  OnlineShopTests.swift
//  OnlineShopTests
//
//  Created by Alsu Faizova on 02.03.2023.
//

import XCTest
@testable import OnlineShop

final class OnlineShopTests: XCTestCase {

    @MainActor
    override func setUp() {
        authorizationService = MockAuthorizationService()
        loginView = MockLoginView()
        confirmSignIn = {}
        
        //Arrange
        presenter = LoginPresenter(
            authorizationService: authorizationService,
            view: loginView,
            confirmSignIn: confirmSignIn)
    }
    
    var authorizationService: MockAuthorizationService!
    var loginView: MockLoginView!
    var confirmSignIn: () -> Void = {}
    var presenter: LoginPresenter!
    
    func testShowLoaderIsCalled() async {
        //Act
        await presenter.logIn(login: "123", password: "123")
        
        //Assert
        let result = await loginView.showLoaderIsCalled
        XCTAssertTrue(result)
    }

    func testValidatorIncorrect() async {
        //Act
        let result = await presenter.logIn(login: "0", password: "123")

        //Assert
        XCTAssertEqual(result, false)
    }
    
    func testValidatorCorrect() async {
        //Act
        await presenter.logIn(login: "123", password: "123")
        let (login, password) = authorizationService.signedInCredentials ?? ("", "")
        
        //Assert
        XCTAssertEqual(login, "123")
        XCTAssertEqual(password, "123")
    }
    
    func testErrorIsCalled() async {
        await presenter.logIn(login: "0", password: "0")
        
        let result = await loginView.showError
        XCTAssertEqual(result as? AuthorizationError, AuthorizationError.unauthorized)
    }
    
//    func testThrowError() async throws {
//        
//        XCTAssertThrowsError(try await presenter.logIn(login: "123", password: "123")) { error in
//            XCTAssertEqual(error as! AuthorizationError, AuthorizationError.confirmationRequired)
//        }
//    }
}
