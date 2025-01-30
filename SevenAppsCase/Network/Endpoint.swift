//
//  Endpoint.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import Foundation

// MARK: - Endpoint Protocol
protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var url: URL? { get }
}

// MARK: - Endpoint
enum UserEndpoint: Endpoint {
    var baseURL: String { "https://jsonplaceholder.typicode.com" }
    
    case users
    
    var path: String {
        switch self {
        case .users:
            return "/users"
        }
    }
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
}
