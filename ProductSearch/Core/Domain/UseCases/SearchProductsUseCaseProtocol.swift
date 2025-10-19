//
//  SearchProductsUseCaseProtocol.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//



// MARK: - Domain Layer - Use Cases
// File: Core/Domain/UseCases/SearchProductsUseCase.swift

import Foundation
protocol SearchProductsUseCaseProtocol: Sendable {
    func execute(query: String?) async throws -> [Product]
}

final class SearchProductsUseCase: SearchProductsUseCaseProtocol {
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(query: String?) async throws -> [Product] {
        let trimmedQuery = query?.trimmingCharacters(in: .whitespaces)
        let searchQuery = trimmedQuery?.isEmpty == false ? trimmedQuery : nil
        return try await repository.searchProducts(query: searchQuery)
    }
}
