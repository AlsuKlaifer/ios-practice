//
//  CatalogViewController.swift
//  OnlineShop
//
//  Created by Teacher on 11.02.2023.
//

import UIKit

class CatalogViewController: UIViewController {
    
    var juiceInfoService: JuiceInfoService = JuiceInfoServiceImplementation.shared

    var presenter: CatalogPresenter!
    var data: [JuiceInfo]!
    
    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
        
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.loadData()
        data = presenter.data
        setup()
        setConstraints()
    }
    
    func show(error: Error) {
        let alertController = UIAlertController(title: "OOOPS", message: "Something went wrong: \(error)", preferredStyle: .alert)
        alertController.addAction(.init(title: "OK", style: .cancel))
        present(alertController, animated: true)
    }
    
    func setup() {
        
        title = "Juice"
        navigationController?.tabBarItem = .init(title: "Catalog", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate ([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CatalogViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openDetails(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CatalogViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "text")
        cell.textLabel?.text = data[indexPath.row].name
        cell.textLabel?.font = .boldSystemFont(ofSize: 18)
        return cell
    }
}
