//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Станислав Климов on 29.09.2020.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let storageManage = StorageManager()
    private let reuseIdentifier = "newsCell"
    private var news: [Article] = []
    private var filteredNews: [Article] = []

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNews()

    }

    private func getNews() { storageManage.getNewsFromStorage(completionHandler: { (news) in
        self.getArticles(from: news)
    })
    }
    
    private func getArticles(from groups: [MainNews]) {
        for item in groups {
            news.append(contentsOf: item.articles)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchNewsCollectionViewCell
        let news = filteredNews[indexPath.row]
        cell.configureWithArticle(from: news)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchBarView", for: indexPath)
        return searchView
    }
}


extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filteredNews.removeAll()
        for item in news {
            if item.description!.lowercased().contains(searchBar.text!.lowercased()) || item.title!.lowercased().contains(searchBar.text!.lowercased()) {
            filteredNews.append(item)
            }
        }
        searchBar.endEditing(true)
        collectionView.reloadData()
    }
}
