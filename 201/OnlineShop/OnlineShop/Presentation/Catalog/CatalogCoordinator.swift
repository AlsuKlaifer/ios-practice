//
//  FlowCoordinator.swift
//  OnlineShop
//
//  Created by Alsu Faizova on 17.02.2023.
//

import UIKit

class FlowCoordinator{
    
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func showDetails() {
        let controller: LoginViewController = storyboard.instantiateViewController(identifier: "DetailsViewController")
    }
}
