//
//  NewsService.swift
//  NewsFeedApps
//
//  Created by Beste Kocaoglu on 13.01.2024.
//

import Foundation
import Alamofire

class NewsService {
    
    // Haberleri çekmek için API'ye istek atan fonksiyon
    func fetchNews(query: String, page: Int, completion: @escaping ([NewsModel]?) -> Void) {
        let apiKey = "77e2c06b7dbd45609681ce2e496b47e8"
        let pageSize = 10 // Sayfa başına gösterilecek haber sayısı
        let startIndex = (page - 1) * pageSize
        let apiUrl = "https://newsapi.org/v2/everything?q=\(query)&page=\(page)&pagesize=\(pageSize)&apiKey=\(apiKey)"
        
        // Alamofire kütüphanesi kullanılarak API'ye HTTP isteği yapılır
        AF.request(apiUrl).responseDecodable(of: NewsApiResponse.self) { response in
            switch response.result {
            case .success(let newsApiResponse):
                // API yanıtı başarılı ise, gelen veriler NewsModel nesnelerine dönüştürülür
                let news = newsApiResponse.articles.map { article in
                    return NewsModel(title: article.title,
                                     description: article.description ?? "",
                                     imageUrl: article.urlToImage ?? "",
                                     date: article.publishedAt ?? "",
                                     source: article.source?.name ?? "",
                                     url: article.url ?? "")
                }
                // Tamamlama bloğu çağrılır ve dönüştürülen haberler ile birlikte haberler ile dönülür
                completion(news)
            case .failure(let error):
                print("Hata: \(error)")
                completion(nil)
            }
        }
    }
}
