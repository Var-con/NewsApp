//
//  URLSenum.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 27.09.2020.
//

import Foundation

enum URLSofMainNews: String, CaseIterable {
    case topBusinessNews = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f4b3d42e36354e0cab0ae06390bb308b"
    case appleNews = "http://newsapi.org/v2/everything?q=apple&from=2020-09-26&to=2020-09-26&sortBy=popularity&apiKey=f4b3d42e36354e0cab0ae06390bb308b"
    case techCrinchNews = "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=f4b3d42e36354e0cab0ae06390bb308b"
    case wallStreetNews = "http://newsapi.org/v2/everything?domains=wsj.com&apiKey=f4b3d42e36354e0cab0ae06390bb308b"
}
