//
//  NewsFromFavouriteCollectionViewController.swift
//  NewsApp
//
//  Created by Станислав Климов on 28.09.2020.
//

import UIKit


class NewsFromFavouriteCollectionViewController: UICollectionViewController {
    
    var groupNews: [MainNews]?
    var allNews: [Article] = []
    var urls: [URLSofMainNews]?
    
    private let storageManager = StorageManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        if Connectivity.isConnectedToInternet {
            getNews()
        } else {
            showAlertAboutNetworkConnection()
            guard let news = groupNews else { return }
            getArticles(from: news)
        }
    }
    
    private func getNewsToStorage() {
        storageManager.addNewsToStorage(with: groupNews!)
    }
    
    
    
    private func getNews() {
        guard let urls = urls else { return }
        for url in urls {
            NetworkManager.shared.fetchNews(from: url) { [self] (news) in
                groupNews?.append(news)
                getArticles(from: self.groupNews!)
            }
        }
    }
 
    private func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func getArticles(from groups: [MainNews]) {
        for item in groups {
                allNews.append(contentsOf: item.articles)
        }
        reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allNews.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "newsCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavoriteNewsCollectionViewCell
        cell.configureWithArticle(from: allNews[indexPath.row])
        return cell
    }
}

extension NewsFromFavouriteCollectionViewController {
    func showAlertAboutNetworkConnection() {
        let alert = UIAlertController(title: "No internet connection",
                                      message: "You're offline. Please check connection to load latest news",
                                      preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
