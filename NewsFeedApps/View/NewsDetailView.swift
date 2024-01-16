//
//  NewsDetailView.swift
//  NewsFeedApps
//
//  Created by Beste Kocaoglu on 13.01.2024.
//

import SwiftUI
import URLImage

struct NewsDetailView: View {
    var news: NewsModel
    @ObservedObject var viewModel: NewsViewModel
    @State private var isWebViewPresented: Bool = false
    @State private var isShareSheetPresented: Bool = false
    @ObservedObject var favoritesViewModel: FavoritesViewModel
    
    

    var body: some View {
        ScrollView {
            // Favori ve Paylaş butonları
            HStack {
                Spacer()

                Button(action: {
                    viewModel.isFavorite.toggle()
                    viewModel.toggleFavoriteStatus(for: news)

                }) {
                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(viewModel.isFavorite ? .red : .gray)
                        .imageScale(.large)
                        .padding()
                }
                .padding(.trailing, 16)

                Button(action: {
                    // Paylaşma işlemi
                    isShareSheetPresented.toggle()
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                        .padding()
                }
            }
            .padding()
            .padding(.top, 20)

            // Haber resmi
            URLImage(URL(string: news.imageUrl)!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .clipped()
            }
            // Haber kaynağı ve tarihi
            HStack {
                // Kaynak ikonu (örneğin, "newspaper.fill" simgesi)
                Image(systemName: "newspaper.fill")
                    .foregroundColor(.gray)
                    .imageScale(.small)
                    

                // Kaynak metni
                Text(news.source)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Spacer()

                // Tarih ikonu (örneğin, "clock.fill" simgesi)
                Image(systemName: "clock.fill")
                    .foregroundColor(.gray)
                    .imageScale(.small)

                // Tarih metni
                Text(formattedDate(from: news.date))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }.padding()


            // Haber başlığı
            Text(news.title)
                .font(.title)
                .fontWeight(.bold)
                .padding()

            // Haber açıklaması
            Text(news.description)
                .font(.body)
                .padding()
                .lineLimit(7)

            

            // "Haber Kaynağına Git" butonu
            Button(action: {
                // Haberin orijinal kaynağına yönlendirme işlemi
                isWebViewPresented.toggle()
            }) {
                Text("News Source")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.brown)
                    .cornerRadius(8)
            }
            .padding()
            .sheet(isPresented: $isWebViewPresented) {
                WebView(urlString: news.url)
            }
        }
        .navigationBarTitle("")
        .sheet(isPresented: $isShareSheetPresented) {
            ShareSheet(activityItems: [news.url])
        }
    }

    private func formattedDate(from dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM yyyy HH:mm"

        if let date = dateFormatterGet.date(from: dateString) {
            return dateFormatterPrint.string(from: date)
        } else {
            return "Tarih Bulunamadı"
        }
    }
}
