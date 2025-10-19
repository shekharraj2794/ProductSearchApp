//
//  ProductDetailView.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//


// File: Presentation/ProductDetail/Views/ProductDetailView.swift
import SwiftUI

struct ProductDetailView: View {
    @StateObject var viewModel: ProductDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Image Gallery
                ImageGalleryView(
                    images: viewModel.product.images,
                    selectedIndex: $viewModel.selectedImageIndex
                )
                
                // Product Info
                VStack(alignment: .leading, spacing: 16) {
                    // Title and Brand
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.product.title)
                            .font(.system(size: 24, weight: .bold))
                        
                        if let brand = viewModel.product.brand {
                            Text(brand)
                                .font(.system(size: 16))
                                .foregroundColor(.secondary)
                        }
                        
                        HStack(spacing: 8) {
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text(String(format: "%.1f", viewModel.product.rating))
                                    .fontWeight(.semibold)
                            }
                            
                            if let reviews = viewModel.product.reviews {
                                Text("(\(reviews.count) reviews)")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .font(.system(size: 14))
                    }
                    
                    // Price
                    HStack(alignment: .firstTextBaseline, spacing: 12) {
                        Text(viewModel.product.formattedDiscountedPrice)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.primary)
                        
                        if viewModel.product.discountPercentage > 0 {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(viewModel.product.formattedPrice)
                                    .font(.system(size: 16))
                                    .foregroundColor(.secondary)
                                    .strikethrough()
                                
                                Text("\(Int(viewModel.product.discountPercentage))% off")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    
                    // Stock Status
                    HStack {
                        Image(systemName: viewModel.product.stock > 0 ? "checkmark.circle.fill" : "xmark.circle.fill")
                        Text(viewModel.product.availabilityStatus ?? (viewModel.product.stock > 0 ? "In Stock" : "Out of Stock"))
                        if viewModel.product.isLowStock {
                            Text("• Only \(viewModel.product.stock) left")
                                .foregroundColor(.orange)
                        }
                    }
                    .font(.system(size: 14))
                    .foregroundColor(viewModel.product.stock > 0 ? .green : .red)
                    
                    Divider()
                    
                    // Description
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.system(size: 18, weight: .semibold))
                        Text(viewModel.product.description)
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                    }
                    
                    // Details
                    if viewModel.product.warrantyInformation != nil ||
                       viewModel.product.shippingInformation != nil ||
                       viewModel.product.returnPolicy != nil {
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Details")
                                .font(.system(size: 18, weight: .semibold))
                            
                            if let warranty = viewModel.product.warrantyInformation {
                                DetailRow(icon: "shield.fill", title: "Warranty", value: warranty)
                            }
                            
                            if let shipping = viewModel.product.shippingInformation {
                                DetailRow(icon: "shippingbox.fill", title: "Shipping", value: shipping)
                            }
                            
                            if let returnPolicy = viewModel.product.returnPolicy {
                                DetailRow(icon: "arrow.uturn.left", title: "Returns", value: returnPolicy)
                            }
                        }
                    }
                    
                    // Reviews
                    if let reviews = viewModel.product.reviews, !reviews.isEmpty {
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Reviews")
                                .font(.system(size: 18, weight: .semibold))
                            
                            ForEach(reviews) { review in
                                ReviewCardView(review: review)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadProductDetail()
        }
    }
}
