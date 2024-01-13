//
//  NewsService.swift
//  NewsFeedApps
//
//  Created by Beste Kocaoglu on 13.01.2024.
//

import Foundation
import Alamofire

class NewsService {
    func fetchNews(query: String, page: Int, completion: @escaping ([NewsModel]?) -> Void) {
        let apiKey = "90f78b5e459f4557a6d285161db89387"
        let pageSize = 10 // Sayfa başına gösterilecek haber sayısı
        let startIndex = (page - 1) * pageSize
        let apiUrl = "https://newsapi.org/v2/everything?q=\(query)&page=\(page)&pagesize=\(pageSize)&apiKey=\(apiKey)"
        

        AF.request(apiUrl).responseDecodable(of: NewsApiResponse.self) { response in
            switch response.result {
            case .success(let newsApiResponse):
                let news = newsApiResponse.articles.map { article in
                    return NewsModel(title: article.title,
                                     description: article.description ?? "",
                                     imageUrl: article.urlToImage ?? "",
                                     date: article.publishedAt ?? "",
                                     source: article.source?.name ?? "",
                                     url: article.url ?? "")
                }
                completion(news)
            case .failure(let error):
                print("Hata: \(error)")
                completion(nil)
            }
        }
    }
}
