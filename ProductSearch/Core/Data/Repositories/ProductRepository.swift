//
//  ProductRepository.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//


// MARK: - Data Layer - Repository Implementation
// File: Core/Data/Repositories/ProductRepository.swift
import Foundation

final class ProductRepository: ProductRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func searchProducts(query: String?) async throws -> [Product] {
        let response: ProductResponse = try await networkService.request(.searchProducts(query: query))
        return response.products
    }
    
    func getProductDetail(id: Int) async throws -> Product {
        try await networkService.request(.productDetail(id: id))
    }
}
