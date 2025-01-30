//
//  NetworkService.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import Foundation

// MARK: - Network Error
enum NetworkError: Error {
    case badURL
    case requestFailed
    case decodingFailed
    case unknown
}

// MARK: - Network Service Protocol
protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(from endpoint: UserEndpoint) async throws -> T
}

// MARK: - Network Service
final class NetworkService: NetworkServiceProtocol {
    func fetchData<T: Decodable>(from endpoint: UserEndpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.badURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.requestFailed
            }

            return try JSONParser.decode(data)
        } catch {
            throw NetworkError.unknown
        }
    }
}
