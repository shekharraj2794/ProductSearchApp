//
//  ImageGalleryView.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//

import SwiftUI

struct ImageGalleryView: View {
    let images: [String]
    @Binding var selectedIndex: Int
    
    var body: some View {
        VStack(spacing: 12) {
            TabView(selection: $selectedIndex) {
                ForEach(images.indices, id: \.self) { index in
                    CachedAsyncImage(url: images[index])
                        .frame(height: 300)
                        .tag(index)
                }
            }
            .frame(height: 300)
            .tabViewStyle(.page(indexDisplayMode: .always))
            
            if images.count > 1 {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(images.indices, id: \.self) { index in
                            CachedAsyncImage(url: images[index])
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(selectedIndex == index ? Color.blue : Color.clear, lineWidth: 2)
                                )
                                .onTapGesture {
                                    selectedIndex = index
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                Text(value)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
        }
    }
}

