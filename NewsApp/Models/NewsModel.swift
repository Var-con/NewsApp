//
//  NewsModel.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 27.09.2020.
//

import Foundation

struct MainNews: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
    var channel: String?
}

// MARK: - Article
struct Article: Codable {
    let author: String?
    let title: String?
    let articleDescription: String?
    let description: String?
    let urlToImage: String?
    let content: String?
}


