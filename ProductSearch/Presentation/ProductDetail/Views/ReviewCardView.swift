//
//  ReviewCardView.swift
//  ProductSearch
//
//  Created by Raj Shekhar on 18/10/25.
//

import SwiftUI

struct ReviewCardView: View {
    let review: Review
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(review.reviewerName)
                        .font(.system(size: 14, weight: .semibold))
                    
                    HStack(spacing: 2) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < review.rating ? "star.fill" : "star")
                                .font(.system(size: 12))
                                .foregroundColor(index < review.rating ? .yellow : .gray)
                        }
                    }
                }
                
                Spacer()
            }
            
            Text(review.comment)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
