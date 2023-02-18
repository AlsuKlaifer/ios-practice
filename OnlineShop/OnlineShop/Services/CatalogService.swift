//
//  CatalogService.swift
//  OnlineShop
//
//  Created by Alsu Faizova on 17.02.2023.
//

import Foundation

struct JuiceInfo{
    var name: String
    var calories: Int
    var price: Int
}

protocol JuiceInfoService{
    func obtainJuiceInfo() -> [JuiceInfo]
}

class JuiceInfoServiceImplementation : JuiceInfoService {
    static let shared: JuiceInfoServiceImplementation = .init()
    
    func obtainJuiceInfo() -> [JuiceInfo] {
        return [
            JuiceInfo(name: "Apple juice", calories: 20, price: 90),
            JuiceInfo(name: "Orange juice", calories: 30, price: 100),
            JuiceInfo(name: "Tomato juice", calories: 53, price: 150),
            JuiceInfo(name: "Multifruit juice", calories: 60, price: 120),
            JuiceInfo(name: "Pear juice", calories: 24, price: 130),
            JuiceInfo(name: "Banana juice", calories: 36, price: 150),
            JuiceInfo(name: "Pineapple juice", calories: 10, price: 110),
            JuiceInfo(name: "Coconut juice", calories: 39, price: 200),
            JuiceInfo(name: "Mango juice", calories: 57, price: 180),
            JuiceInfo(name: "Kiwi juice", calories: 35, price: 190),
        ]
    }
    
}
