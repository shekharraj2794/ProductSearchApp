//
//  CategoryScrollView.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//


// File: Presentation/ProductList/Views/CategoryScrollView.swift
import SwiftUI
struct CategoryScrollView: View {
    let categories: [String]
    let selectedCategory: String?
    let onCategoryTap: (String?) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                CategoryChip(
                    title: "All",
                    isSelected: selectedCategory == nil,
                    action: { onCategoryTap(nil) }
                )
                
                ForEach(categories, id: \.self) { category in
                    CategoryChip(
                        title: category.capitalized,
                        isSelected: selectedCategory == category,
                        action: { onCategoryTap(category) }
                    )
                }
            }
            .padding(.vertical, 8)
        }
    }
}


struct CategoryChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: isSelected ? .semibold : .regular))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}
