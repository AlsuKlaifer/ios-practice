//
//  ViewController.swift
//  exam2
//
//  Created by Alsu Faizova on 19.11.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)

    var accounts: [Accounts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        self.tableView.rowHeight = 60
        tableView.dataSource = self
        tableView.delegate = self
        setConstraints()
        setData()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Cell.cell.rawValue)
    }

    private func setData() {
        Task {
            do {
                accounts = try await NetworkManager.shared.getUserData()
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accounts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: Cell.cell.rawValue)
        var configuration = UIListContentConfiguration.cell()
        let realName = accounts[indexPath.row].user.realName

        configuration.text = realName
        cell.contentConfiguration = configuration

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Users"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ProfileViewController()
        vc.account = accounts[indexPath.row]
        show(vc, sender: self)
    }
    
    private func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    enum Cell: String {
        case cell
    }
    
}
