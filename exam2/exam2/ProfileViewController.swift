//
//  ProfileViewController.swift
//  exam2
//
//  Created by Alsu Faizova on 19.11.2022.
//

import UIKit

class ProfileViewController: UIViewController{
    var account: Accounts?
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 60
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let realName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
    
    private let phoneNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray5
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)

    private func loadImage(url: URL) async {
        imageView.image = nil
        let urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData
        )
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            guard !Task.isCancelled else { return }
            imageView.image = UIImage(data: data)
        } catch {
            print("could not load image")
        }
    }
    var loadingTask: Task<Void, Never>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraints()
        setup()
        
    }

    func setup() {
        view.backgroundColor = .black
        realName.text = account?.user.realName
        loadingTask?.cancel()
        loadingTask = Task {
            await loadImage(url: (account?.user.avatar)!)
        }
        
        phoneNumber.text = "\(account?.user.phoneNumber ?? "") \(account?.user.nickname ?? "" )"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func setConstraints() {
        view.addSubview(realName)
        view.addSubview(imageView)
        view.addSubview(phoneNumber)
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.widthAnchor.constraint(equalToConstant: 120),

            realName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            realName.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            phoneNumber.topAnchor.constraint(equalTo: realName.bottomAnchor, constant: 10),
            phoneNumber.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            tableView.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

        ])
    }
}

extension ProfileViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value2, reuseIdentifier: "Cell")
        var configuration = UIListContentConfiguration.cell()
//        let title = account?.settings.items[indexPath.row]
//        let icon = account?.settings.items[indexPath.row]
//        let imageURL = account?.settings.items[indexPath.row]
//
        configuration.text = "name"
        cell.contentConfiguration = configuration
//
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        account?.settings.count ?? 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
}
