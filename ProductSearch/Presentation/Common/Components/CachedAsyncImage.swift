//
//  CachedAsyncImage.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//
import SwiftUI

struct CachedAsyncImage: View {
    let url: String
    @State private var image: UIImage?
    @State private var isLoading = true
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if isLoading {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .overlay(
                        ProgressView()
                    )
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
        }
        .task {
            await loadImage()
        }
    }
    
    private func loadImage() async {
        // Check cache first
        if let cachedImage = ImageCache.shared.image(for: url) {
            self.image = cachedImage
            self.isLoading = false
            return
        }
        
        // Load from network
        guard let imageURL = URL(string: url) else {
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: imageURL)
            if let loadedImage = UIImage(data: data) {
                ImageCache.shared.setImage(loadedImage, for: url)
                await MainActor.run {
                    self.image = loadedImage
                }
            }
        } catch {
            print("Failed to load image: \(error)")
        }
        
        await MainActor.run {
            self.isLoading = false
        }
    }
}
