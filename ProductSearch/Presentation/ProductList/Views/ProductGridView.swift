//
//  ProductGridView.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//
import SwiftUI

struct ProductGridView: View {
    let products: [Product]
    let onProductTap: (Product) -> Void
    
    private let columns = [
        GridItem(.flexible(), spacing: AppConstants.gridSpacing),
        GridItem(.flexible(), spacing: AppConstants.gridSpacing)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: AppConstants.gridSpacing) {
                ForEach(products) { product in
                    ProductCardView(product: product)
                        .onTapGesture {
                            onProductTap(product)
                        }
                }
            }
            .padding()
        }
    }
}
