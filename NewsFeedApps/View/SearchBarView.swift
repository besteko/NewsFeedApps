//
//  SearchBarView.swift
//  NewsFeedApps
//
//  Created by Beste Kocaoglu on 13.01.2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchQuery: String
    var onSearchButtonClicked: () -> Void

    var body: some View {
        HStack {
            // Arama çubuğu
            TextField("Type a text", text: $searchQuery)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                

           // Arama butonu
            Button(action: {
                onSearchButtonClicked()
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
        }
    }
}
