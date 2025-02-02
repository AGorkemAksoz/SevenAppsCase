//
//  NetworkService.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import Foundation

// MARK: - Network Service Protocol
protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(from endpoint: UserEndpoint, method: HTTPMethods) async throws -> T
}

// MARK: - Network Service
final class NetworkService: NetworkServiceProtocol {
    
    func fetchData<T>(from endpoint: UserEndpoint, method: HTTPMethods) async throws -> T where T: Decodable {
        guard let url = endpoint.url else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.requestFailed
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingFailed
            }
        } catch {
            throw NetworkError.unknown
        }
    }
}
