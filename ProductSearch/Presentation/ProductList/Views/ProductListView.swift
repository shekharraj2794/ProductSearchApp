//
//  ProductListView.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//


// MARK: - Presentation Layer - Views
// File: Presentation/ProductList/Views/ProductListView.swift

import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel: ProductListViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                SearchBar(text: $viewModel.searchText)
                    .padding()
                
                if !viewModel.categories.isEmpty {
                    CategoryScrollView(
                        categories: viewModel.categories,
                        selectedCategory: viewModel.filteredCategory,
                        onCategoryTap: { category in
                            viewModel.filterByCategory(category)
                        }
                    )
                    .padding(.horizontal)
                }
                
                ZStack {
                    if viewModel.isLoading {
                        LoadingView()
                    } else if viewModel.isEmpty {
                        EmptyStateView(
                            message: viewModel.searchText.isEmpty ? "No products available" : "No products found for '\(viewModel.searchText)'"
                        )
                    } else {
                        ProductGridView(
                            products: viewModel.filteredProducts,
                            onProductTap: { product in
                                viewModel.selectProduct(product)
                            }
                        )
                        .refreshable {
                            await viewModel.refresh()
                        }
                    }
                }
            }
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !viewModel.searchText.isEmpty || viewModel.filteredCategory != nil {
                        Button("Clear") {
                            viewModel.clearSearch()
                        }
                    }
                }
            }
            .navigationDestination(item: $viewModel.selectedProduct) { product in
                ProductDetailView(
                    viewModel: DIContainer.shared.makeProductDetailViewModel(product: product)
                )
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") {
                    viewModel.errorMessage = nil
                }
            } message: {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
    }
}