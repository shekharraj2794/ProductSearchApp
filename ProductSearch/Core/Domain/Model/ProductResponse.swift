//
//  ProductResponse.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//


// File: Core/Domain/Models/ProductResponse.swift
import Foundation

struct ProductResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
