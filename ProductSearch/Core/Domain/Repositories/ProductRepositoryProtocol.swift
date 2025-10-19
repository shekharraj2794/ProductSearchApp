//
//  ProductRepositoryProtocol.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//


// MARK: - Domain Layer - Repository Protocol
// File: Core/Domain/Repositories/ProductRepositoryProtocol.swift

protocol ProductRepositoryProtocol: Sendable {
    func searchProducts(query: String?) async throws -> [Product]
    func getProductDetail(id: Int) async throws -> Product
}
