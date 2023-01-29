//
//  ViewController.swift
//  Animations
//
//  Created by Alsu Faizova on 24.09.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .darkGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        createLayerAndAnimate()
    }
    func createLayerAndAnimate(){
        let layer = CALayer()
        layer.frame = CGRect(x: 50, y: 150, width: 100, height: 100)
        view.layer.addSublayer(layer)
        
        layer.backgroundColor = UIColor.orange.cgColor
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.toValue = UIColor.red.cgColor
        colorAnimation.duration = 3
        colorAnimation.repeatCount = .infinity
        colorAnimation.autoreverses = true
        let key = "backround color animation"
        layer.add(colorAnimation, forKey: key)
        
        let positionAnimation = CASpringAnimation(keyPath: "position.x")
        positionAnimation.fromValue = CGFloat(75)
        positionAnimation.toValue = CGFloat(75)
        positionAnimation.duration = 0.5
        positionAnimation.repeatCount = .infinity
        positionAnimation.autoreverses = true
        let positionKey = "x animation"
        layer.add(positionAnimation, forKey: positionKey)
    }

}

