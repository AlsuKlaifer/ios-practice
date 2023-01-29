//
//  CatsViewController.swift
//  homework4
//
//  Created by Alsu Faizova on 07.10.2022.
//

import UIKit

class CatsViewController: UIViewController {

    @IBOutlet var catsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let num = Int.random(in: 1...3)
        var name: String
        switch num{
            case 1: name = "cat1"
            case 2: name = "cat2"
            case 3: name = "cat3"
            default:
                name = "cat1"
        }
        catsImageView.image = UIImage(named: name)
    }
    
    @IBAction func closeTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
