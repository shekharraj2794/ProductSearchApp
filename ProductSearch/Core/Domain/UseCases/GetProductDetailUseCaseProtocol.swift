//
//  GetProductDetailUseCaseProtocol.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//

import Foundation

protocol GetProductDetailUseCaseProtocol: Sendable {
    func execute(id: Int) async throws -> Product
}

final class GetProductDetailUseCase: GetProductDetailUseCaseProtocol {
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> Product {
        try await repository.getProductDetail(id: id)
    }
}
