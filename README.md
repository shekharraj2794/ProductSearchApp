# 🛍️ Product Search App

A modern iOS application showcasing Clean Architecture principles, built with SwiftUI, Swift 6, and Combine framework.

![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-green.svg)

## ✨ Features

- 🔍 Real-time product search with debouncing
- 🏷️ Category filtering
- 📱 Product detail view with image gallery
- ⭐ Product ratings and reviews
- 💰 Discount pricing display
- 📦 Stock availability tracking
- 🔄 Pull-to-refresh
- 💾 Image caching
- 🎨 Modern UI with native components

## 🏗️ Architecture

This project implements **Clean Architecture** with **MVVM** pattern:
```
Presentation Layer (Views + ViewModels)
        ↓
Domain Layer (UseCases + Models)
        ↓
Data Layer (Repository + Network)
```

### Key Components:
- **Views**: SwiftUI declarative UI
- **ViewModels**: State management with Combine
- **UseCases**: Business logic encapsulation
- **Repository**: Data access abstraction
- **Network Service**: API integration

## 🛠️ Technologies

- **SwiftUI**: Modern declarative UI framework
- **Swift 6**: Latest Swift with strict concurrency
- **Combine**: Reactive programming for search debouncing
- **Async/Await**: Structured concurrency
- **Protocol-Oriented Design**: Easy testing and mocking
- **Dependency Injection**: Loose coupling

## 📦 Project Structure
```
ProductSearchApp/
├── App/                    # App entry point
├── Core/
│   ├── Domain/            # Business logic & models
│   ├── Data/              # Repositories & networking
│   └── Utilities/         # Extensions & helpers
├── Presentation/          # Views & ViewModels
└── DI/                    # Dependency injection
```

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 17.0+
- Swift 6.0+

### Installation

1. Clone the repository
```bash
git clone https://github.com/shekharraj2794/ProductSearchApp.git
```

2. Open the project
```bash
cd ProductSearchApp
open ProductSearchApp.xcodeproj
```

3. Build and run (⌘ + R)

## 🎯 API

This app uses the [DummyJSON API](https://dummyjson.com/):
- Search products: `GET /products/search?q={query}`
- Get all products: `GET /products`
- Product detail: `GET /products/{id}`

## 🧪 Testing

Run tests with `⌘ + U`

The project includes:
- Unit tests for ViewModels
- Integration tests for Network layer
- Mock objects for isolated testing

## 📱 Screenshots

_Add screenshots of your app here_

## 🎨 Design Patterns

- **MVVM**: Separation of UI and business logic
- **Repository Pattern**: Data source abstraction
- **UseCase Pattern**: Business logic isolation
- **Dependency Injection**: Testability
- **Protocol-Oriented**: Mock-friendly architecture

## 🔑 Key Features

### Search with Debouncing
```swift
$searchText
    .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
    .sink { query in
        Task { await self.searchProducts(query: query) }
    }
```

### Image Caching
Custom image cache implementation using `NSCache` for optimal performance.

### Error Handling
Comprehensive error handling with user-friendly messages.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Author

**Shekhar Raj**
- GitHub: [@shekharraj2794](https://github.com/shekharraj2794)

## 🙏 Acknowledgments

- [DummyJSON](https://dummyjson.com/) for the free API
- Apple's SwiftUI documentation

---

⭐ If you found this helpful, please give it a star!
