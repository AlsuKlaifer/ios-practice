//
//  LoginVC.swift
//  OnlineShop
//
//  Created by Alsu Faizova on 11.02.2023.
//

import UIKit

@MainActor
class LoginViewController: UIViewController {
    @IBOutlet private var loginField: UITextField!
    @IBOutlet private var passwordField: UITextField!
    
    var presenter: LoginPresenter!
    
    func showLoader(){}
    func hideLoader(){}
    func show(error: Error)
    {}
    @IBAction private func login() {
        guard let login = loginField.text, let password = passwordField.text else {return}
    }
}
