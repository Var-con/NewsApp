//
//  MainPageNewsCollectionViewCell.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 27.09.2020.
//

import UIKit

class MainPageNewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var titleView: UIView!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var favoriteImage: UIImageView!
    @IBOutlet var favoriteButtonOutlet: UIButton!
    private var isFavorite: Bool?
    
    @IBAction func addToFavoriteButton(_ sender: Any) {
        if isFavorite! {
            deleteFromFavorite()
        } else {
            addToFavorite()
        }
    }
    func configureWithArticle(from channel: URLSofMainNews) {
        switch channel {
        case .appleNews:
            nameLabel.text = "Apple News"
            descriptionLabel.text = "All articles mentioning Apple from yesterday, sorted by popular publishers first"
        case .techCrinchNews :
            nameLabel.text = "TechCrunch News"
            descriptionLabel.text = "Top headlines from TechCrunch right now"
        case .topBusinessNews :
            nameLabel.text = "USA Buiseness News"
            descriptionLabel.text = "Top business headlines in the US right now"
        case .wallStreetNews :
            nameLabel.text = "Wall Street Journal"
            descriptionLabel.text = "All articles published by the Wall Street Journal in the last 6 months, sorted by recent first"
        }
        setupNameLabel()
        setupDescriptionLabel()
        isFavorite = FavoriteChannelManager.shared.checkFavoriteChannel(with: nameLabel.text!)
        setupFavoriteImage()
        setupFavoriteButtonLabel()
    }
    
    private func setupNameLabel() {
        titleView.layer.cornerRadius = 10
        titleView.layer.borderWidth = 2
        if #available(iOS 13.0, *) {
            titleView.layer.borderColor = CGColor(red: 0.2, green: 0.4, blue: 0.7, alpha: 1)
        }
    }
    
    
    private func setupDescriptionLabel() {
        descriptionView.layer.cornerRadius = 10
        descriptionView.layer.borderWidth = 2
        if #available(iOS 13.0, *) {
            descriptionView.layer.borderColor = CGColor(red: 0.5, green: 0.3, blue: 0.7, alpha: 1)
        }
    }
    private func setupFavoriteImage() {
        guard let isFavorite = isFavorite else { return }
        var tapGesture: UITapGestureRecognizer?
        if isFavorite {
            favoriteImage.tintColor = .red
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteFromFavorite))
        } else {
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(addToFavorite))
        }
        favoriteImage.isUserInteractionEnabled = true
        favoriteImage.addGestureRecognizer(tapGesture!)
    }
    
    private func setupFavoriteButtonLabel() {
        guard let isFavorite = isFavorite else { return }
        if isFavorite {
            favoriteButtonOutlet.setTitle("Delete from favorite", for: .normal)
            
        } else {
            favoriteButtonOutlet.setTitle("Add to favorite", for: .normal)
        }
    }
    
    @objc private func addToFavorite() {
        favoriteImage.tintColor = .red
        isFavorite = true
        guard let text = nameLabel.text else { return }
        FavoriteChannelManager.shared.takeNewFavoriteChannel(with: text)
        setupFavoriteButtonLabel()
    }
    
    @objc private func deleteFromFavorite() {
        favoriteImage.tintColor = .white
        isFavorite = false
        setupFavoriteButtonLabel()
        FavoriteChannelManager.shared.deleteFromFavorite(with: (nameLabel.text)!)
    }
    
    
}
