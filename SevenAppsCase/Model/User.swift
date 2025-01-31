//
//  User.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company
}

// MARK: - Model
struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Geo: Codable {
    let lat: String
    let lng: String
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}
