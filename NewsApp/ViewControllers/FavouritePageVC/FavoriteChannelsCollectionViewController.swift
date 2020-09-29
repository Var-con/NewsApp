//
//  FavoriteChannelsCollectionViewController.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 28.09.2020.
//

import UIKit


class FavoriteChannelsCollectionViewController: UICollectionViewController, FavoriteChannelDelegate {
    
    @IBOutlet var showNewsButtonOutlet: UIBarButtonItem!
    private let storageManager = StorageManager()
    private let reuseIdentifier = "favoriteChannelCell"
    private var favoriteChanells: [String] = []
    private var channels: [URLSofMainNews] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavoriteChanels()
        getURLSfromFavouriteNames()
        setupShowNewsButton()
    }
    
    @IBAction func showNews(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "newsSegue", sender: nil)
    }
    
    private func reloadData() {
        collectionView.reloadData()
    }
    
    private func getFavoriteChanels() {
        guard let array = FavoriteChannelManager.shared.fetchFavoriteChannels() else { return }
        favoriteChanells.removeAll()
        favoriteChanells = array
        reloadData()
    }
    
    private func setupShowNewsButton() {
        if channels.count == 0 {
            showNewsButtonOutlet.isEnabled = false
        } else {
            showNewsButtonOutlet.isEnabled = true
        }
        
    }
    
    
    
    func deleteFromView(with indexPath: Int) {
        channels.remove(at: indexPath)
        favoriteChanells.remove(at: indexPath)
        reloadData()
        setupShowNewsButton()
    }
    
    func getURLSfromFavouriteNames() {
        channels.removeAll()
        for channel in favoriteChanells {
            if channel == "Apple News" {
                channels.append(.appleNews)
            } else if channel == "TechCrunch News" {
                channels.append(.techCrinchNews)
            } else if channel == "USA Buiseness News" {
                channels.append(.topBusinessNews)
            } else if channel == "Wall Street Journal" {
                channels.append(.wallStreetNews)
            }
        }
    }
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteChanells.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavoriteChannelCollectionViewCell
        cell.configureWithChannel(from: favoriteChanells[indexPath.row])
        cell.numberOfCell = indexPath.row
        cell.delegate = self
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsSegue" {
            var allNews: [MainNews] = []
            guard let destinationVC = segue.destination as? NewsFromFavouriteCollectionViewController else { return }
            storageManager.getNewsFromStorage() { news in
            allNews = news
            }
            var news: [MainNews] = []
            for info in allNews {
                for channel in channels {
                    if channel.rawValue == info.channel {
                        news.append(info)
                    }
                }
            }
            destinationVC.groupNews = news
            destinationVC.urls = channels
        }
    }
}
