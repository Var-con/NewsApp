//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Станислав Климов on 28.09.2020.
//

import XCTest
@testable import NewsApp

class NewsAppTests: XCTestCase {
    
    var sutStorageManager: StorageManager!
    var sutNetworkManager: NetworkManager!
    var sutFavouriteChannelLogic: FavoriteChannelManager!
    var sutMainPage: MainPageCollectionViewController!
    var sutImageManager: ImageManager!
    override func setUpWithError() throws {
      sutStorageManager = StorageManager()
        sutNetworkManager = NetworkManager()
        sutFavouriteChannelLogic = FavoriteChannelManager()
        sutMainPage = MainPageCollectionViewController()
        sutImageManager = ImageManager()
    }

    override func tearDownWithError() throws {

    }

    func testStorage() throws {
        let news: [MainNews] = []
        XCTAssertNoThrow(sutStorageManager.addNewsToStorage(with: news))
    }
    
    func testStorageExtract() {
        sutStorageManager.getNewsFromStorage { (news) in
            XCTAssertNotNil(news)
        }
    }
    
    func testNetworkExtract() {
        let url = URLSofMainNews.appleNews
        sutNetworkManager.fetchNews(from: url) { (news) in
            XCTAssertNotNil(news)
        }
    }
    
    func testGetArticleFromUrl() {
        let url = URLSofMainNews.topBusinessNews
        sutNetworkManager.fetchNews(from: url) { (news) in
            let articlse = news.articles
            XCTAssertNotNil(articlse)
        }
    }
    
    func testAddingToFavourite() {
        let string = "Foo Bar Buzz"
        sutFavouriteChannelLogic.takeNewFavoriteChannel(with: string)
        let bool = sutFavouriteChannelLogic.checkFavoriteChannel(with: string)
        XCTAssertTrue(bool)
        sutFavouriteChannelLogic.deleteFromFavorite(with: string)
    }
    
    func testDeletingFromFavorites() {
        let string = "Foo Bar Buzz"
        sutFavouriteChannelLogic.deleteFromFavorite(with: string)
        let bool = sutFavouriteChannelLogic.checkFavoriteChannel(with: string)
        XCTAssertFalse(bool)
    }
    
    func testFavouriteChannels() {
        let string = "Foo Bar Buzz"
        sutFavouriteChannelLogic.takeNewFavoriteChannel(with: string)
        let channels = sutFavouriteChannelLogic.fetchFavoriteChannels()
        XCTAssertNotNil(channels)
    }
    
    func testImageManager() {
        let imageUrl = "https://images.wsj.net/im-237920/social"
        let data = sutImageManager.getImageData(from: imageUrl)
        XCTAssertNotNil(data)
    }
    
    func testNoImageDataFromWrongUrl() {
        let imageUrl = "123"
        let data = sutImageManager.getImageData(from: imageUrl)
        XCTAssertNil(data)
    }
}
