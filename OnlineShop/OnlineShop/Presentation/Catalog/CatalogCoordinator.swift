//
//  CatalogCoordinator.swift
//  OnlineShop
//
//  Created by Alsu Faizova on 17.02.2023.
//

import UIKit

class CatalogCoordinator{
    var navigationController: UINavigationController?
        
    func showCatalog() -> UIViewController {
        let controller = CatalogViewController()
        let presenter = CatalogPresenter()
        controller.presenter = presenter
        presenter.view = controller
        presenter.showDetails = showDetails
        navigationController = UINavigationController(rootViewController: controller)
        return navigationController!
    }
    
    func showDetails(data: JuiceInfo) {
        let detailsViewController = DetailsViewController()
        detailsViewController.juiceInfo = data
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
