//
//  DIContainer.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//
import Foundation
// MARK: - Dependency Injection Container
// File: DI/DIContainer.swift

final class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    // MARK: - Network Layer
    private lazy var networkService: NetworkServiceProtocol = {
        NetworkService()
    }()
    
    // MARK: - Repositories
    private lazy var productRepository: ProductRepositoryProtocol = {
        ProductRepository(networkService: networkService)
    }()
    
    // MARK: - Use Cases
    func makeSearchProductsUseCase() -> SearchProductsUseCaseProtocol {
        SearchProductsUseCase(repository: productRepository)
    }
    
    func makeGetProductDetailUseCase() -> GetProductDetailUseCaseProtocol {
        GetProductDetailUseCase(repository: productRepository)
    }
    
    // MARK: - ViewModels
    func makeProductListViewModel() -> ProductListViewModel {
        ProductListViewModel(searchUseCase: makeSearchProductsUseCase())
    }
    
    func makeProductDetailViewModel(product: Product) -> ProductDetailViewModel {
        ProductDetailViewModel(
            product: product,
            getProductDetailUseCase: makeGetProductDetailUseCase()
        )
    }
}
