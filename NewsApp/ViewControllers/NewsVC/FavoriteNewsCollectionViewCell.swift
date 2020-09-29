//
//  FavoriteNewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Станислав Климов on 28.09.2020.
//

import UIKit

class FavoriteNewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var titleView: UIView!
    @IBOutlet var descriptionView: UIView!

    private var cellArticle: Article?
    

    func configureWithArticle(from article: Article) {
        cellArticle = article
        nameLabel.text = article.title
        if article.articleDescription != nil {
            descriptionLabel.text = article.articleDescription
        } else {
        descriptionLabel.text =  article.description
        }
        guard let imageUrl = article.urlToImage else { return }
        guard let data = ImageManager.shared.getImageData(from: imageUrl) else { return }
        DispatchQueue.main.async {
            self.newsImage.image = UIImage(data: data)
        }
        setupImage()
        setupNameLabel()
        setupDescriptionLabel()
    }
    
    
    private func setupImage() {
        newsImage.layer.cornerRadius = 20
        newsImage.layer.borderWidth = 2
        if #available(iOS 13.0, *) {
            newsImage.layer.borderColor = CGColor(red: 0.5, green: 0.3, blue: 0.7, alpha: 1)
        }
        newsImage.layer.shadowRadius = 10
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
    
}
