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
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .onAppear(perform: {
                viewModel.populateFavoriteNews()
            })
            .navigationBarTitle("Favoriler")
        }
    }
}
