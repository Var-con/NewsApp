//
//  FavoriteChannelCollectionViewCell.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 28.09.2020.
//

import UIKit

protocol FavoriteChannelDelegate {
    func deleteFromView(with indexPath: Int)
}

class FavoriteChannelCollectionViewCell: UICollectionViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var titleView: UIView!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var favoriteImage: UIImageView!
    @IBOutlet var favoriteButtonOutlet: UIButton!
    var numberOfCell: Int?
    var delegate: FavoriteChannelDelegate!
    @IBAction func addToFavoriteButton(_ sender: Any) {
        deleteFromFavorite()
    }
    func configureWithChannel(from channel: String) {
        if channel == "Apple News" {
            nameLabel.text = channel
            descriptionLabel.text = "All articles mentioning Apple from yesterday, sorted by popular publishers first"
        } else if channel == "Bitcoin News" {
            nameLabel.text = channel
            descriptionLabel.text = "All articles about Bitcoin from the last month, sorted by recent first"
        } else if channel == "TechCrunch News" {
            nameLabel.text = channel
            descriptionLabel.text = "Top headlines from TechCrunch right now"
            descriptionLabel.text = "Top headlines from TechCrunch right now"
        } else if channel == "USA Buiseness News" {
            nameLabel.text = channel
            descriptionLabel.text = "Top business headlines in the US right now"
        } else if channel == "Wall Street Journal" {
            nameLabel.text = channel
            descriptionLabel.text = "All articles published by the Wall Street Journal in the last 6 months, sorted by recent first"
        }
        setupNameLabel()
        setupDescriptionLabel()
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
        
        favoriteImage.tintColor = .red
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteFromFavorite))
        
        favoriteImage.isUserInteractionEnabled = true
        favoriteImage.addGestureRecognizer(tapGesture)
    }
    
    private func setupFavoriteButtonLabel() {
        favoriteButtonOutlet.setTitle("Delete from favorite", for: .normal)
        
    }
    
    @objc private func deleteFromFavorite() {
        FavoriteChannelManager.shared.deleteFromFavorite(with: nameLabel.text!)
        delegate.deleteFromView(with: numberOfCell ?? 0)
    }
    
}
