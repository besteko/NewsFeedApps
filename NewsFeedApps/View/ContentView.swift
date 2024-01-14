//
//  ContentView.swift
//  NewsFeedApps
//
//  Created by Beste Kocaoglu on 13.01.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            // İlk sekme
            NavigationView {
                NewsListView(viewModel: NewsViewModel(newsService: NewsService(), favoritesViewModel: FavoritesViewModel()))
            }
            .tabItem {
                Image(systemName: "newspaper")
                Text("News")
            }

            // İkinci sekme
            NavigationView {
                FavoritesView(viewModel: FavoritesViewModel())
            }
            .tabItem {
                Image(systemName: "star")
                Text("Favorites")
            }
        }
        .background(Color.white) // TabBar'ın arka plan rengini beyaz yap
        .accentColor(.brown)
    }
}

