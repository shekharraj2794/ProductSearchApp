//
//  NetworkError.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//


// MARK: - Data Layer - Network
// File: Core/Data/Network/NetworkError.swift
import Foundation
enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case serverError(statusCode: Int)
    case noData
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL configuration"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError:
            return "Failed to decode response"
        case .serverError(let code):
            return "Server error: \(code)"
        case .noData:
            return "No data received"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
