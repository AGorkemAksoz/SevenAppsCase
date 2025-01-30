//
//  JSONParser.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import Foundation

// MARK: - JSON Parser
final class JSONParser {
    static func decode<T: Decodable>(_ data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
