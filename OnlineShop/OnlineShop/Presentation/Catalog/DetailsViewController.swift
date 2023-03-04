//
//  DetailsViewController.swift
//  OnlineShop
//
//  Created by Alsu Faizova on 17.02.2023.
//

import UIKit

class DetailsViewController: UIViewController{
    
    var juiceInfo: JuiceInfo!
//    var juiceInfoService: JuiceInfoService = JuiceInfoServiceImplementation.shared
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var image = UIImage(systemName: "takeoutbag.and.cup.and.straw")

    private var caloriesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setConstraints()
        setup()
    }
    
    func setConstraints()
    {
        let imageView = UIImageView(image: image)
        let stackview = UIStackView(arrangedSubviews: [nameLabel, imageView, caloriesLabel, priceLabel])
        stackview.axis = .vertical
        stackview.spacing = 40
        stackview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackview)
        
        NSLayoutConstraint.activate ([
            stackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 180),
        ])
    }
    
    func setup(){        
        nameLabel.text = juiceInfo.name
        caloriesLabel.text = "Calories: \(juiceInfo.calories)"
        priceLabel.text = "Price: \(juiceInfo.price)$"
    }
}
