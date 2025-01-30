//
//  UserRepository.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import Foundation

protocol UserRepositoryProtocol {
    func getUsers() async throws -> [User]
}

final class UserRepository: UserRepositoryProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func getUsers() async throws -> [User] {
        return try await networkService.fetchData(from: .users)
    }
}
