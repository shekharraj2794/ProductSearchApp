//
//  View+Extensions.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//

import SwiftUI

extension View {
    func cardStyle() -> some View {
        self.modifier(CardModifier())
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
