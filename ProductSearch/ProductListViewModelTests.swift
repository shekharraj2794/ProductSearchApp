//
//  ProductListViewModelTests.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//


// MARK: - Preview Helpers
//#if DEBUG
//extension Product {
//    static let preview = Product(
//        id: 1,
//        title: "iPhone 13 Pro",
//        description: "The latest iPhone with pro camera system",
//        price: 999.99,
//        discountPercentage: 10,
//        rating: 4.5,
//        stock: 50,
//        brand: "Apple",
//        category: "smartphones",
//        thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg",
//        images: [
//            "https://cdn.dummyjson.com/product-images/1/1.jpg",
//            "https://cdn.dummyjson.com/product-images/1/2.jpg"
//        ],
//        tags: ["smartphones", "apple"],
//        sku: "APL-001",
//        weight: 200,
//        dimensions: Dimensions(width: 7.1, height: 14.7, depth: 0.3),
//        warrantyInformation: "1 year warranty",
//        shippingInformation: "Ships in 1-2 business days",
//        availabilityStatus: "In Stock",
//        reviews: [
//            Review(
//                rating: 5,
//                comment: "Great phone!",
//                date: "2024-01-01",
//                reviewerName: "John Doe",
//                reviewerEmail: "john@example.com"
//            )
//        ],
//        returnPolicy: "30 days return policy",
//        minimumOrderQuantity: 1
//    )
//}
//
//#Preview("Product List") {
//    ProductListView(
//        viewModel: DIContainer.shared.makeProductListViewModel()
//    )
//}
//
//#Preview("Product Detail") {
//    NavigationStack {
//        ProductDetailView(
//            viewModel: DIContainer.shared.makeProductDetailViewModel(product: .preview)
//        )
//    }
//}
//
//#Preview("Product Card") {
//    ProductCardView(product: .preview)
//        .frame(width: 180)
//        .padding()
//}
//
//#Preview("Search Bar") {
//    SearchBar(text: .constant("iPhone"))
//        .padding()
//}
//
//#Preview("Loading View") {
//    LoadingView()
//}
//
//#Preview("Empty State") {
//    EmptyStateView(message: "No products found")
//}
//
//#Preview("Error View") {
//    ErrorView(message: "Failed to load products") {
//        print("Retry tapped")
//    }
//}
//#endif



// MARK: - Unit Tests Structure
/*
File: ProductSearchTests/ViewModelTests/ProductListViewModelTests.swift

import XCTest
@testable import ProductSearch

final class ProductListViewModelTests: XCTestCase {
    var sut: ProductListViewModel!
    var mockSearchUseCase: MockSearchProductsUseCase!
    
    override func setUp() {
        super.setUp()
        mockSearchUseCase = MockSearchProductsUseCase()
        sut = ProductListViewModel(searchUseCase: mockSearchUseCase)
    }
    
    override func tearDown() {
        sut = nil
        mockSearchUseCase = nil
        super.tearDown()
    }
    
    func testLoadInitialProducts() async {
        // Given
        let expectedProducts = [Product.preview]
        mockSearchUseCase.productsToReturn = expectedProducts
        
        // When
        await sut.loadInitialProducts()
        
        // Then
        XCTAssertEqual(sut.products, expectedProducts)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
    }
    
    func testSearchWithQuery() async {
        // Given
        let query = "iPhone"
        let expectedProducts = [Product.preview]
        mockSearchUseCase.productsToReturn = expectedProducts
        
        // When
        sut.searchText = query
        try? await Task.sleep(nanoseconds: 600_000_000) // Wait for debounce
        
        // Then
        XCTAssertEqual(mockSearchUseCase.lastQuery, query)
        XCTAssertEqual(sut.products, expectedProducts)
    }
    
    func testErrorHandling() async {
        // Given
        mockSearchUseCase.shouldThrowError = true
        
        // When
        await sut.loadInitialProducts()
        
        // Then
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertTrue(sut.products.isEmpty)
    }
}

// Mock classes for testing
final class MockSearchProductsUseCase: SearchProductsUseCaseProtocol {
    var productsToReturn: [Product] = []
    var shouldThrowError = false
    var lastQuery: String?
    
    func execute(query: String?) async throws -> [Product] {
        lastQuery = query
        if shouldThrowError {
            throw NetworkError.unknown(NSError(domain: "Test", code: -1))
        }
        return productsToReturn
    }
}
*/

// MARK: - Integration Tests Structure
/*
File: ProductSearchTests/IntegrationTests/NetworkIntegrationTests.swift

import XCTest
@testable import ProductSearch

final class NetworkIntegrationTests: XCTestCase {
    var networkService: NetworkService!
    var repository: ProductRepository!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
        repository = ProductRepository(networkService: networkService)
    }
    
    func testSearchProductsAPI() async throws {
        // When
        let products = try await repository.searchProducts(query: "phone")
        
        // Then
        XCTAssertFalse(products.isEmpty)
        XCTAssertTrue(products.contains { $0.title.lowercased().contains("phone") })
    }
    
    func testGetAllProductsAPI() async throws {
        // When
        let products = try await repository.searchProducts(query: nil)
        
        // Then
        XCTAssertFalse(products.isEmpty)
    }
    
    func testGetProductDetailAPI() async throws {
        // When
        let product = try await repository.getProductDetail(id: 1)
        
        // Then
        XCTAssertEqual(product.id, 1)
        XCTAssertFalse(product.title.isEmpty)
    }
}
*/

// MARK: - README Documentation
/*
# Product Search App

A modern iOS app built with SwiftUI, demonstrating Clean Architecture principles with structured concurrency and Combine framework.

## 🏗️ Architecture

### Clean Architecture Layers

1. **Domain Layer** (`Core/Domain/`)
   - Models: Pure Swift data structures
   - Use Cases: Business logic
   - Repository Protocols: Data access abstractions

2. **Data Layer** (`Core/Data/`)
   - Repositories: Implementation of domain protocols
   - Network: API communication
   - Cache: Local data persistence

3. **Presentation Layer** (`Presentation/`)
   - Views: SwiftUI UI components
   - ViewModels: State management with Combine
   - Common: Reusable components

4. **DI Layer** (`DI/`)
   - Dependency Injection Container
   - Object lifecycle management

## 🚀 Features

- ✅ Product search with debounced input
- ✅ Category filtering
- ✅ Product detail view with image gallery
- ✅ Pull-to-refresh
- ✅ Image caching
- ✅ Error handling
- ✅ Loading states
- ✅ Empty states
- ✅ Review display
- ✅ Discount badges
- ✅ Stock information

## 🛠️ Technologies

- **SwiftUI**: Declarative UI framework
- **Swift 6**: Latest Swift features
- **Combine**: Reactive programming
- **Structured Concurrency**: async/await
- **URLSession**: Networking
- **NSCache**: Image caching

## 📦 Dependencies

No external dependencies! Pure Swift and Apple frameworks.

## 🏃 Running the App

1. Open `ProductSearch.xcodeproj`
2. Select a simulator or device
3. Press `Cmd + R`

## 🧪 Testing

Run tests with `Cmd + U`

### Test Coverage
- Unit tests for ViewModels
- Integration tests for Network layer
- Mock objects for isolation

## 📱 Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 6.0+

## 🎨 Design Patterns

- **MVVM**: Separation of UI and business logic
- **Repository Pattern**: Data access abstraction
- **Use Case Pattern**: Business logic encapsulation
- **Dependency Injection**: Loose coupling
- **Protocol-Oriented**: Testability

## 📚 Project Structure

```
ProductSearch/
├── App/                    # App entry point
├── Core/
│   ├── Domain/            # Business logic
│   ├── Data/              # Data layer
│   └── Utilities/         # Helper classes
├── Presentation/          # UI layer
└── DI/                    # Dependency injection
```

## 🔄 Data Flow

```
View → ViewModel → UseCase → Repository → NetworkService → API
                                                              ↓
View ← ViewModel ← UseCase ← Repository ← NetworkService ← Response
```

## 🎯 Best Practices

1. **Separation of Concerns**: Each layer has single responsibility
2. **Testability**: Protocol-based design enables easy mocking
3. **Type Safety**: Leverage Swift's type system
4. **Error Handling**: Proper error types and user feedback
5. **Memory Management**: Weak references in closures
6. **Concurrency**: MainActor for UI updates
7. **Code Quality**: Clear naming and documentation

## 📝 API Documentation

Base URL: `https://dummyjson.com/products`

### Endpoints
- `GET /products` - Get all products
- `GET /products/search?q={query}` - Search products
- `GET /products/{id}` - Get product detail

## 🔐 License

MIT License

## 👨‍💻 Author

Your Name

---

Happy Coding! 🎉
*/
