//
//  String+Extensions..swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//

// File: Core/Utilities/Extensions/String+Extensions.swift
import Foundation

extension String {
    var isValidSearchQuery: Bool {
        !self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
