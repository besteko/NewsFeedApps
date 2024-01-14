//
//  NewsFeedAppsTests.swift
//  NewsFeedAppsTests
//
//  Created by Beste Kocaoglu on 13.01.2024.
//

import XCTest
@testable import NewsFeedApps

final class NewsServiceTests: XCTestCase {

    func testFetchNews() {
            let newsService = NewsService()
            let expectation = XCTestExpectation(description: "Haberleri başarıyla getirme beklentisi")

            // Test verileri
            let query = "example"
            let page = 1

            // Test fonksiyonunu çağır
            newsService.fetchNews(query: query, page: page) { news in
                // Gelen haberleri kontrol et
                XCTAssertNotNil(news, "Haber listesi nil olmamalı")
                XCTAssertFalse(news!.isEmpty, "Haber listesi boş olmamalı")

                // Diğer test kriterlerini buraya ekleyebilirsiniz
                // Örneğin, dönen haberlerin istediğiniz özelliklere sahip olup olmadığını kontrol edebilirsiniz

                expectation.fulfill() // Beklentiyi karşılandı olarak işaretle
            }

            // Belirli bir süre içinde beklentiyi karşılayamazsa test başarısız kabul edilecek
            wait(for: [expectation], timeout: 5.0)
        }
    }
