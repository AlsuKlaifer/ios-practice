//
//  NetworkManager.swift
//  exam2
//
//  Created by Alsu Faizova on 19.11.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
}

enum Links: String {
    case reqres = "https://raw.githubusercontent.com/AZigangaraev/images/main/telegram.json"
}

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func getUserData() async throws -> [Accounts] {
        guard let url = URL(string: Links.reqres.rawValue) else {
            throw NetworkError.invalidURL
        }
        let urlRequest = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(Response.self, from: data)
        
        return response.accounts
    }
}
