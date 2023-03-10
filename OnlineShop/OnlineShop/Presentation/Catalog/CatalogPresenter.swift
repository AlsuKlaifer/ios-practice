//
//  CatalogPresenter.swift
//  OnlineShop
//
//  Created by Alsu Faizova on 17.02.2023.
//

import UIKit

class CatalogPresenter {
    private let juiceInfoService: JuiceInfoService = JuiceInfoServiceImplementation.shared

    var showDetails: (JuiceInfo) -> Void = { _ in }

    weak var view: CatalogViewController?
    var data: [JuiceInfo]?

    func loadData() {
        do {
            try data = juiceInfoService.obtainJuiceInfo()
        } catch {
            view?.show(error: error)
        }
    }

    func openDetails(at index: Int) {
        showDetails(data![index])
    }
}
