//
//  ImageService.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 27.09.2020.
//

import Foundation

class ImageManager {
    static let shared = ImageManager()
    
    init() {}
    
    func getImageData(from url: String?) -> Data? {
        guard let url = url else { return nil }
        guard let imageURl = URL(string: url) else { return nil }
        if let imageDataFromCache = getCachedImage(url: url) {
            return imageDataFromCache
        } else {
            guard let imageData = try? Data(contentsOf: imageURl) else { return nil }
            saveDataToCache(with: imageData, and: imageURl)
            return imageData
        }
    }
    
    private func getCachedImage(url: String) -> Data? {
        guard let imageURl = URL(string: url) else { return nil }
        let urlRequest = URLRequest(url: imageURl)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return cachedResponse.data
        } else { return nil }
    }
    
    private func saveDataToCache(with data: Data, and url: URL) {
        let urlResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: -1, textEncodingName: nil)
        guard let nowUrl = urlResponse.url else { return }
        let cachedResponse = CachedURLResponse(response: urlResponse, data: data)
        let urlRequest = URLRequest(url: nowUrl)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
}
