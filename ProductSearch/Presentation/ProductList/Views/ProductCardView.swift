//
//  ProductCardView.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//

import SwiftUI
struct ProductCardView: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                CachedAsyncImage(url: product.thumbnail)
                    .frame(height: 140)
                    .clipped()
                    .cornerRadius(8)
                
                if product.discountPercentage > 0 {
                    Text("\(Int(product.discountPercentage))% OFF")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 4)
                        .background(Color.red)
                        .cornerRadius(4)
                        .padding(8)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.system(size: 14, weight: .medium))
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                if let brand = product.brand {
                    Text(brand)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", product.rating))
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                
                HStack(spacing: 6) {
                    Text(product.formattedDiscountedPrice)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.primary)
                    
                    if product.discountPercentage > 0 {
                        Text(product.formattedPrice)
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .strikethrough()
                    }
                }
                
                if product.isLowStock {
                    Text("Only \(product.stock) left")
                        .font(.system(size: 11))
                        .foregroundColor(.orange)
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal, 4)
        }
        .cardStyle()
    }
}
