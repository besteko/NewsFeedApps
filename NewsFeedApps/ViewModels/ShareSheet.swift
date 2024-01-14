//
//  ShareSheet.swift
//  NewsFeedApps
//
//  Created by Beste Kocaoglu on 13.01.2024.
//

import SwiftUI

// `ShareSheet` adlı yapı, SwiftUI uygulamalarında paylaşım sayfalarını entegre etmeyi sağlar.
struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
     
    // `UIActivityViewController` oluşturulur ve yapılandırılır.
    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheet>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareSheet>) {
        // Güncelleme mantığı buraya eklenebilir.
    }
}
