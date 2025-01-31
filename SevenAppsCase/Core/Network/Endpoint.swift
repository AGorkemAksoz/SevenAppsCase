//
//  Endpoint.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import Foundation

// MARK: - Endpoint Protocol
protocol Endpoint {
    var path: String { get }
    var url: URL? { get }
}

// MARK: - Endpoint
enum UserEndpoint: Endpoint {
    case users
    
    var path: String {
        switch self {
        case .users:
            return "/users"
        }
    }
    
    var url: URL? {
        return URL(string: "https://jsonplaceholder.typicode.com" + path)
    }
}
