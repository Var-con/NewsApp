//
//  MainPageCollectionViewController.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 27.09.2020.
//

import UIKit

class MainPageCollectionViewController: UICollectionViewController {
    
    let channels = URLSofMainNews.self
    var groupNews: [MainNews] = []
    private let storageManager = StorageManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        if Connectivity.isConnectedToInternet {
            getNews() { [self] in
                self.getNewsToStorage()
            }
         } else {
             showAlertAboutNetworkConnection()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

    private func getNewsToStorage(){
        storageManager.clearStorage()
        storageManager.addNewsToStorage(with: groupNews)
    }

    private func getNews(completionHandler: @escaping () -> Void) {
        for url in URLSofMainNews.allCases {
            NetworkManager.shared.fetchNews(from: url) { (news) in
                self.groupNews.append(news)
                completionHandler()
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return channels.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "mainPageNewsCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainPageNewsCollectionViewCell
        cell.favoriteImage.tintColor = .white
        cell.configureWithArticle(from: channels.allCases[indexPath.row])
        return cell
    }
}

extension MainPageCollectionViewController {
    func showAlertAboutNetworkConnection() {
        let alert = UIAlertController(title: "No internet connection",
                                      message: "You're offline. Please check connection to load latest news",
                                      preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
