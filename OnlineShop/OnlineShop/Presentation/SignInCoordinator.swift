//
//  SignInCoordinator.swift
//  OnlineShop
//
//  Created by Alsu Faizova on 03.03.2023.
//

import UIKit

class SignInCoordinator {
    
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    private weak var navigationController: UINavigationController?
    var services: ServiceLocator!
    
    @MainActor
    func start() -> UIViewController {
        let controller: LoginViewController = storyboard.instantiateViewController(identifier: "LoginViewController")
        let presenter = LoginPresenter(
            authorizationService: services.resolve(),
            view: controller,
            confirmSignIn: { [self] in
                showConfirmation()
            }
        )
        controller.presenter = presenter
        let navigationController = UINavigationController(rootViewController: controller)
        self.navigationController = navigationController
        return navigationController
    }
    
    private func showConfirmation() {
        let controller: ConfirmationViewController = storyboard.instantiateViewController(identifier: "ConfirmationViewController")
        let presenter = ConfirmationPresenter(authorizationService: services.resolve())
        controller.presenter = presenter
        navigationController?.pushViewController(controller, animated: true)
    }
}
