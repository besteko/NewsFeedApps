//
//  NewsViewModelTests.swift
//  NewsFeedAppsTests
//
//  Created by Beste Kocaoglu on 14.01.2024.
//

import XCTest
@testable import NewsFeedApps

final class NewsViewModelTests: XCTestCase {

    func testFetchNews() {
           // Haber servisi mock'ları
           class MockNewsService: NewsService {
               var fetchNewsCalled = false

               override func fetchNews(query: String, page: Int, completion: @escaping ([NewsModel]?) -> Void) {
                   fetchNewsCalled = true
                   // Test verileriyle doldurulmuş haberler
                   let testNews = [
                       NewsModel(title: "Test News 1", description: "Test Description 1", imageUrl: "test-url-1", date: "2022-01-01", source: "Test Source 1", url: "test-news-url-1"),
                       NewsModel(title: "Test News 2", description: "Test Description 2", imageUrl: "test-url-2", date: "2022-01-02", source: "Test Source 2", url: "test-news-url-2")
                   ]
                   completion(testNews)
               }
           }

           // Favori haberler view model mock'u
           class MockFavoritesViewModel: FavoritesViewModel {
               override func isFavorite(news: NewsModel) -> Bool {
                   return false // Favori değil varsayılan olarak
               }
           }

           // Test için gerekli mock'ları kullanarak NewsViewModel oluştur
           let mockNewsService = MockNewsService()
           let mockFavoritesViewModel = MockFavoritesViewModel()
           let newsViewModel = NewsViewModel(newsService: mockNewsService, favoritesViewModel: mockFavoritesViewModel)

           // NewsViewModel'in fetchNews fonksiyonunu çağır
           newsViewModel.fetchNews(query: "test")

           // fetchNews fonksiyonu NewsService'den çağrıldı mı kontrol et
           XCTAssertTrue(mockNewsService.fetchNewsCalled, "fetchNews fonksiyonu çağrılmadı")

           // NewsViewModel'in haber listesi dolu mu kontrol et
           XCTAssertEqual(newsViewModel.news.count, 2, "Haberler başarıyla getirilmedi")
       }
   }
