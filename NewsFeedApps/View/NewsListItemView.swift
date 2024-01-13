//
//  NewsListItemView.swift
//  NewsFeedApps
//
//  Created by Beste Kocaoglu on 13.01.2024.
//
import SwiftUI
import URLImage

struct NewsListItemView: View {
    var news: NewsModel

    var body: some View {
        HStack(alignment: .top) {
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
                // Handle the case when imageUrl is nil
                Color.gray
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            }

            // Haber başlığı ve açıklaması
            VStack(alignment: .leading, spacing: 8) {
                Text(news.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(2)

                Text(news.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(3)
            }
            .padding(.trailing, 8)
            .layoutPriority(1) // İçeriğin sığmasını sağlamak için
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
