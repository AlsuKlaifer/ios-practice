//
//  ConfirmationViewController.swift
//  OnlineShop
//
//  Created by Alsu Faizova on 03.03.2023.
//

import UIKit

class ConfirmationViewController: UIViewController {
    var presenter: ConfirmationPresenter!
    
    @IBAction private func confirm() {
        presenter.confirm()
    }
}
