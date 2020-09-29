//
//  NewsAppUITests.swift
//  NewsAppUITests
//
//  Created by Станислав Климов on 28.09.2020.
//

import XCTest

class NewsAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testOpenMainPages() {
        
        let tabBar = XCUIApplication().tabBars["Tab Bar"]
        let favoriteChannelsButton = tabBar.buttons["Favorite Channels"]
        favoriteChannelsButton.tap()
        tabBar.buttons["Search"].tap()
        favoriteChannelsButton.tap()
        tabBar.buttons["All news"].tap()
    }
    
}
