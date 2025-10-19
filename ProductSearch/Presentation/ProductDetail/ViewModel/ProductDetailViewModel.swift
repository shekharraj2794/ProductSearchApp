//
//  ProductDetailViewModel.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//
import Foundation
import Combine

@MainActor
final class ProductDetailViewModel: ObservableObject {
    @Published var product: Product
    @Published var selectedImageIndex: Int = 0
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let getProductDetailUseCase: GetProductDetailUseCaseProtocol
    
    init(product: Product, getProductDetailUseCase: GetProductDetailUseCaseProtocol) {
        self.product = product
        self.getProductDetailUseCase = getProductDetailUseCase
    }
    
    func loadProductDetail() async {
        isLoading = true
        errorMessage = nil
        
        do {
            product = try await getProductDetailUseCase.execute(id: product.id)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func selectImage(at index: Int) {
        guard index >= 0 && index < product.images.count else { return }
        selectedImageIndex = index
    }
}
