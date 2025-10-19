//
//  ProductSearchApp.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 16/10/25.
//

import SwiftUI

@main
struct ProductSearchApp: App {
    var body: some Scene {
        WindowGroup {
            ProductListView(
                viewModel: DIContainer.shared.makeProductListViewModel()
            )
        }
    }
}
