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
        VStack {
            Text("Favorites News")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(hue: 0.054, saturation: 0.616, brightness: 0.845, opacity: 0.761))
                .multilineTextAlignment(.center)
                .padding(.top)

            ScrollView {
                VStack {
                    // Favori haber listesi
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.favoriteNews, id: \.id) { newsItem in
                            NavigationLink(destination: NewsDetailView(news: newsItem, viewModel: NewsViewModel(newsService: NewsService(), favoritesViewModel: FavoritesViewModel(), newsModel: newsItem), favoritesViewModel: FavoritesViewModel())) {
                                NewsListItemView(news: newsItem)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding()
                    }

                    // Favori haber yoksa gösterilecek metin
                    if viewModel.favoriteNews.isEmpty {
                        Text("Favori haber yok.")
                            .font(.headline)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 200.0)
                    }
                }
                .padding()
            }
        }
        .onAppear(perform: {
            viewModel.populateFavoriteNews()
        })
    }
}


