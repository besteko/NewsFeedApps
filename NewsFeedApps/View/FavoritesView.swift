//
//  FavoritesView.swift
//  NewsFeedApps
//
//  Created by Beste Kocaoglu on 13.01.2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel

    var body: some View {
        NavigationView {
            VStack {
                
                Text("Favorites News")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hue: 0.054, saturation: 0.616, brightness: 0.845, opacity: 0.761))
                    .multilineTextAlignment(.center)
                    
                
                // Favori haber listesi
                List(viewModel.favoriteNews, id: \.id) { newsItem in
                    NavigationLink(destination: NewsDetailView(news: newsItem, viewModel: NewsViewModel(newsService: NewsService(), favoritesViewModel: FavoritesViewModel(), newsModel: newsItem), favoritesViewModel: FavoritesViewModel())) {
                        NewsListItemView(news: newsItem)
                    }
                }
                .padding()

                // Favori haber yoksa gösterilecek metin
                if viewModel.favoriteNews.isEmpty {
                    Text("Favori haber yok.")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 200.0)
                        
                }
            }
            .onAppear(perform: {
                viewModel.populateFavoriteNews()
            })
           // .navigationBarTitle("Favoriler")
        }
    }
}
