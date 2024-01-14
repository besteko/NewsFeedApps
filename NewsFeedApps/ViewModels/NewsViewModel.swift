//
//  NewsViewModel.swift
//  NewsFeedApps
//
//  Created by Beste Kocaoglu on 13.01.2024.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var news: [NewsModel] = []
    private var currentPage: Int = 1
    private var isFetching = false
    private let newsService: NewsService
    @Published var favoritesViewModel: FavoritesViewModel
    
    // For News Detail
    @Published var isFavorite: Bool = false

    // İnit metodu, haber servisi ve favori haberlerin view modelini alır
    // İsteğe bağlı olarak bir haber modeli de alabilir
    init(newsService: NewsService, favoritesViewModel: FavoritesViewModel, newsModel: NewsModel? = nil) {
        self.newsService = newsService
        self.favoritesViewModel = favoritesViewModel
        // Eğer bir haber modeli varsa, favori durumu kontrol edilir
        if let newsModel {
            isFavorite = self.isFavoriteNews(news: newsModel)
        }
    }

    func toggleFavoriteStatus(for news: NewsModel) {
        favoritesViewModel.toggleFavoriteStatus(for: news)
        isFavorite = isFavoriteNews(news: news)
    }
    
    func isFavoriteNews(news: NewsModel) -> Bool {
        favoritesViewModel.isFavorite(news: news)
    }

    // Haberleri belirli bir sorgu ile çeker
    func fetchNews(query: String) {
        guard !isFetching else { return }
        isFetching = true
        let defaultQuery = query.isEmpty ? "besiktas" : query
        newsService.fetchNews(query: defaultQuery, page: currentPage) { [weak self] result in
            guard let self = self else { return }

            if let newNews = result {
                self.news = newNews
                self.currentPage = 2
            }

            self.isFetching = false
        }
    }
    
    // Bir sonraki sayfayı çeker

    func fetchNextPage(query: String) {
        guard !isFetching else { return }
        isFetching = true

        newsService.fetchNews(query: query, page: currentPage) { [weak self] result in
            guard let self = self else { return }

            if let newNews = result {
                // Yeni haberler mevcut haberlere eklenir ve sayfa numarası güncellenir
                self.news.append(contentsOf: newNews)
                self.currentPage += 1
            }

            self.isFetching = false
        }
    }
}
