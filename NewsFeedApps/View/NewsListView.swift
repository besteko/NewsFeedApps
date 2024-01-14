//
//  NewsListView.swift
//  NewsFeedApps
//
//  Created by Beste Kocaoglu on 13.01.2024.
//
import SwiftUI

struct NewsListView: View {
    @ObservedObject var viewModel: NewsViewModel
    @State private var searchQuery: String = ""

    var body: some View {
        VStack {
            // Sayfa başlığı
            Text("Appcent News App")
                .foregroundColor(Color(hue: 0.054, saturation: 0.616, brightness: 0.845, opacity: 0.761))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                

            // Arama çubuğu
            SearchBarView(searchQuery: $searchQuery, onSearchButtonClicked: {
                viewModel.fetchNews(query: searchQuery)
            })
            .onChange(of: searchQuery, perform: { newValue in
                viewModel.fetchNews(query: newValue)
            })
            .padding()

            // Haber listesi
            List {
                ForEach(viewModel.news, id: \.url) { newsItem in
                    NavigationLink(destination: NewsDetailView(news: newsItem, viewModel: NewsViewModel(newsService: NewsService(), favoritesViewModel: FavoritesViewModel(), newsModel: newsItem), favoritesViewModel: FavoritesViewModel())) {
                        NewsListItemView(news: newsItem)
                            .onAppear {
                                // Eğer sona gelindiyse pagination çağrısı yap
                                if newsItem == viewModel.news.last {
                                    let query = searchQuery.isEmpty ? "besiktas" : searchQuery
                                    viewModel.fetchNextPage(query: query)
                                }
                            }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchNews(query: "besiktas") // Varsayılan bir sorgu ile haberleri getir
        }
    }
}
