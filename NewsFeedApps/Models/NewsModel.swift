//
//  NewsModel.swift
//  NewsFeedApps
//
//  Created by Beste Kocaoglu on 13.01.2024.
//

import Foundation

struct NewsModel: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var imageUrl: String
    var date: String
    var source: String
    var url: String
    var isFavorite: Bool = false

    // Hashable uygulaması
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: NewsModel, rhs: NewsModel) -> Bool {
        return lhs.id == rhs.id
    }
}
