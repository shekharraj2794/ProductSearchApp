//
//  Product.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//


// MARK: - Domain Layer - Models
// File: Core/Domain/Models/Product.swift

import Foundation

struct Product: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String?
    let category: String
    let thumbnail: String
    let images: [String]
    let tags: [String]?
    let sku: String?
    let weight: Int?
    let dimensions: Dimensions?
    let warrantyInformation: String?
    let shippingInformation: String?
    let availabilityStatus: String?
    let reviews: [Review]?
    let returnPolicy: String?
    let minimumOrderQuantity: Int?
    
    var discountedPrice: Double {
        price - (price * discountPercentage / 100)
    }
    
    var isLowStock: Bool {
        stock < 10
    }
    
    var formattedPrice: String {
        String(format: "$%.2f", price)
    }
    
    var formattedDiscountedPrice: String {
        String(format: "$%.2f", discountedPrice)
    }
}

struct Dimensions: Codable, Hashable {
    let width: Double
    let height: Double
    let depth: Double
}

struct Review: Codable, Hashable, Identifiable {
    var id: String { "\(reviewerEmail)-\(date)" }
    let rating: Int
    let comment: String
    let date: String
    let reviewerName: String
    let reviewerEmail: String
}

