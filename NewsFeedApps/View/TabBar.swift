//
//  TabBar.swift
//  NewsFeedApps
//
//  Created by Beste Kocaoglu on 13.01.2024.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            // İlk sekme - Haberler
            NewsListView(viewModel: NewsViewModel(newsService: NewsService(), favoritesViewModel: FavoritesViewModel()))
                .tabItem {
                    Label("Haberler", systemImage: "newspaper")
                }

            // İkinci sekme - Favori Haberler
            FavoritesView(viewModel: FavoritesViewModel())
                .tabItem {
                    Label("Favoriler", systemImage: "star")
                }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
