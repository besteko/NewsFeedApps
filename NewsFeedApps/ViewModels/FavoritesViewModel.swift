//
//  FavoritesViewModel.swift
//  NewsFeedApps
//
//  Created by Beste Kocaoglu on 13.01.2024.
//

import Foundation
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var favoriteNews: [NewsModel] = []
    
    func populateFavoriteNews(){
        favoriteNews = self.getFavoriteNewsFromLocal()
    }
    
    func addFavorite(news: NewsModel) {
        var favoriteNews = self.getFavoriteNewsFromLocal()
        favoriteNews.append(news)
        self.setFavoriteNews(news: favoriteNews)
    }

    func removeFavorite(news: NewsModel) {
        var favoriteNews = self.getFavoriteNewsFromLocal()
        if let index = favoriteNews.firstIndex(where: { $0.title == news.title }) {
            favoriteNews.remove(at: index)
            self.setFavoriteNews(news: favoriteNews)
        }
    }

    func isFavorite(news: NewsModel) -> Bool {
        let isFavorite = self.getFavoriteNewsFromLocal().contains(where: { $0.title == news.title })
        return isFavorite
    }

    func toggleFavoriteStatus(for news: NewsModel) {
        if isFavorite(news: news) {
            removeFavorite(news: news)
        } else {
            addFavorite(news: news)
        }
    }
    
    func getFavoriteNewsFromLocal() -> [NewsModel] {
        if let savedData = UserDefaults.standard.data(forKey: "favoriteNews"),
           let decodedModel = try? JSONDecoder().decode([NewsModel].self, from: savedData) {
            return decodedModel
        }
        return []
    }
    
    func setFavoriteNews(news: [NewsModel]) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(news) {
            UserDefaults.standard.set(encodedData, forKey: "favoriteNews")
        }
    }
    
}
