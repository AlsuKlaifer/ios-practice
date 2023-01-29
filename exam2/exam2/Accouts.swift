//
//  User.swift
//  exam2
//
//  Created by Alsu Faizova on 19.11.2022.
//

import Foundation

struct Response: Codable{
    let accounts: [Accounts]
}

struct Accounts: Codable {
    let user: User
    let settings: [Settings]
}

struct User: Codable {
    let phoneNumber: String?
    let nickname: String
    let realName: String
    let avatar: URL
}

struct Settings: Codable {
    let items: [Items]
}

struct Items: Codable {
    let title: String
    let icon: URL
    let value: String?
}
