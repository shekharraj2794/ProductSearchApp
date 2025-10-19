//
//  ProductListViewModel.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//


// MARK: - Presentation Layer - ViewModels
// File: Presentation/ProductList/ViewModels/ProductListViewModel.swift

import Foundation
import Combine

@MainActor
final class ProductListViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var products: [Product] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedProduct: Product?
    @Published var filteredCategory: String?
    
    // MARK: - Private Properties
    private let searchUseCase: SearchProductsUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    private var searchTask: Task<Void, Never>?
    
    // MARK: - Computed Properties
    var categories: [String] {
        Array(Set(products.map { $0.category })).sorted()
    }
    
    var filteredProducts: [Product] {
        guard let category = filteredCategory else { return products }
        return products.filter { $0.category == category }
    }
    
    var isEmpty: Bool {
        products.isEmpty && !isLoading
    }
    
    // MARK: - Initialization
    init(searchUseCase: SearchProductsUseCaseProtocol) {
        self.searchUseCase = searchUseCase
        setupSearchDebounce()
        loadInitialProducts()
    }
    
    // MARK: - Public Methods
    func loadInitialProducts() {
        Task {
            await searchProducts(query: nil)
        }
    }
    
    func refresh() async {
        await searchProducts(query: searchText.isEmpty ? nil : searchText)
    }
    
    func selectProduct(_ product: Product) {
        selectedProduct = product
    }
    
    func clearSearch() {
        searchText = ""
        filteredCategory = nil
    }
    
    func filterByCategory(_ category: String?) {
        filteredCategory = category
    }
    
    // MARK: - Private Methods
    private func setupSearchDebounce() {
        $searchText
            .debounce(for: .seconds(AppConstants.defaultDebounceTime), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.searchTask?.cancel()
                self?.searchTask = Task {
                    await self?.searchProducts(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
    private func searchProducts(query: String?) async {
        guard !Task.isCancelled else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            products = try await searchUseCase.execute(query: query)
        } catch {
            errorMessage = error.localizedDescription
            products = []
        }
        
        isLoading = false
    }
}
