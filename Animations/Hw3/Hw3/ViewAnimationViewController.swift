//
//  ViewAnimationViewController.swift
//  Hw3
//
//  Created by Alsu Faizova on 30.09.2022.
//

import UIKit

class ViewAnimationViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        NotificationCenter.default.addObserver(
            self, selector: #selector(reanimate), name: UIApplication.willEnterForegroundNotification,
            object: nil)
    }
    
    @objc func reanimate() {
        animate()
    }
    
    private let label: UILabel = .init()
    private let circle: UIView = .init()
    private let line1: UIView = .init()
    private let line2: UIView = .init()
    private let label2: UILabel = .init()
    private let label3: UILabel = .init()
    private let burger: UILabel = .init()
    private let fries: UILabel = .init()
    
    private func setup() {
        view.backgroundColor = UIColor(red: 0, green: 0.3, blue: 0, alpha: 1)

        view.addSubview(label)
        label.text = "Вкусно - и точка"
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .orange
        label.sizeToFit()
        label.frame.origin = CGPoint(x: 40, y: 80)
        
        view.addSubview(circle)
        circle.frame = CGRect(x: -view.bounds.width, y: 350, width: 80, height: 80)
        circle.layer.cornerRadius = 40
        circle.backgroundColor = .red
        
        func setupLine(line: UIView, x: Double, y: Double){
            view.addSubview(line)
            line.frame = CGRect(x: x, y: y, width: 50, height: 200)
            line.backgroundColor = .orange
            line.clipsToBounds = true
            line.layer.cornerRadius = 25
            line.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        }
        
        setupLine(line: line1, x: 500, y: 230)
        setupLine(line: line2, x: -50, y: 450)
        
        func setupLabel(label: UILabel, string: String, y: Double){
            view.addSubview(label)
            label.text = string
            label.font = .boldSystemFont(ofSize: 30)
            label.textColor = .orange
            label.frame.origin = CGPoint(x: view.bounds.width, y: y)
            label.sizeToFit()
        }
        
        setupLabel(label: label2, string: "Название меняется,", y: 500)
        setupLabel(label: label3, string: "любовь остается", y: 550)
        
        view.addSubview(burger)
        burger.text = "🍔"
        burger.font = .systemFont(ofSize: 70)
        burger.sizeToFit()
        burger.frame.origin = CGPoint(x: view.bounds.width, y: 630)
        
        view.addSubview(fries)
        fries.text = "🍟"
        fries.font = .systemFont(ofSize: 70)
        fries.sizeToFit()
        fries.frame.origin = CGPoint(x: -fries.bounds.width, y: 720)
    }
    
    private func animate() {
        UIView.animate(
            withDuration:1,
            delay: 1,
            options: [.repeat, .autoreverse]
        ) { [self] in
            label.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        }

        UIView.animateKeyframes(
            withDuration: 1.5,
            delay: 0.5,
            options: []
        ) { [self] in
            UIView.addKeyframe(
                withRelativeStartTime: 0, relativeDuration: 1
            ) { [self] in
                line1.frame.origin = CGPoint(x: 180, y: -200)
                line2.frame.origin = CGPoint(x: 270, y: 900)
            }
            UIView.addKeyframe(
                withRelativeStartTime: 0.5, relativeDuration: 2
            ) { [self] in
                line1.frame.origin = CGPoint(x: 180, y: 230)
                line1.transform = CGAffineTransform(rotationAngle: .pi/1.2)
                line2.frame.origin = CGPoint(x: 270, y: 230)
                line2.transform = CGAffineTransform(rotationAngle: .pi/1.2)
                circle.frame.origin.x = 80
            }
            UIView.addKeyframe(
                withRelativeStartTime: 0.9, relativeDuration: 0.25
            ) { [self] in
                label2.frame.origin.x = 30
                label3.frame.origin.x = 110
            }
        }
        
        UIView.animate(
            withDuration: 3,
            delay: 2.5,
            options: [.repeat, .autoreverse]
        ) { [self] in
            burger.frame.origin.x = 0
            burger.transform = CGAffineTransform(rotationAngle: .pi/6)
            fries.frame.origin.x = 320
            fries.transform = CGAffineTransform(rotationAngle:  -.pi/6)
        }
    }
}
