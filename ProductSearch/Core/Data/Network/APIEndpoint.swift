//
//  APIEndpoint.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//


// File: Core/Data/Network/APIEndpoint.swift
import Foundation

enum APIEndpoint {
    case searchProducts(query: String?)
    case productDetail(id: Int)
    case allProducts
    
    private var baseURL: String {
        "https://dummyjson.com/products"
    }
    
    var url: URL? {
        switch self {
        case .searchProducts(let query):
            if let query = query, !query.isEmpty {
                let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
                return URL(string: "\(baseURL)/search?q=\(encodedQuery)")
            } else {
                return URL(string: baseURL)
            }
        case .productDetail(let id):
            return URL(string: "\(baseURL)/\(id)")
        case .allProducts:
            return URL(string: baseURL)
        }
    }
}
