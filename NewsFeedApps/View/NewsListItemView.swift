//
//  NewsListItemView.swift
//  NewsFeedApps
//
//  Created by Beste Kocaoglu on 13.01.2024.
//
import SwiftUI
import URLImage


// Haber listesi öğelerini temsil eden SwiftUI görünümü
struct NewsListItemView: View {
    var news: NewsModel

    var body: some View {
        HStack {
            // Haber başlığı ve açıklaması
            VStack(alignment: .leading, spacing: 4) {
                Text(news.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    

                Text(news.description)
                    .font(.subheadline)
                    .foregroundColor(.brown)
                    .lineLimit(3)
            }
            .layoutPriority(1) // İçeriğin sığmasını sağlamak için

            // Haber resmi
            if let imageUrl = URL(string: news.imageUrl) {
                URLImage(imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                }
            } else {
                // imageUrl nil olduğunda uygulanacak durum
                Color.gray
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            }
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

