//
//  CardModifier.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//

// MARK: - Common Modifiers
// File: Presentation/Common/Modifiers/CardModifier.swift
import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(.systemBackground))
            .cornerRadius(AppConstants.cardCornerRadius)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
