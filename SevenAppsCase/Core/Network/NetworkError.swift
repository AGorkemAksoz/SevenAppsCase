//
//  NetworkError.swift
//  SevenAppsCase
//
//  Created by Ali Görkem Aksöz on 2.02.2025.
//

import Foundation

// MARK: - Network Error
enum NetworkError: String, Error {
    case badURL
    case requestFailed
    case decodingFailed
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .badURL:
            return "Geçersiz URL."
        case .requestFailed:
            return "Ağ bağlantısı hatası. Lütfen internetinizi kontrol edin."
        case .decodingFailed:
            return "Veri çözümlenirken bir hata oluştu."
        case .unknown:
            return "Bilinmeyen bir hata meydana geldi."
        }
    }
}
