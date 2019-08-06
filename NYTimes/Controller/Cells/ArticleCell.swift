//
//  ArticleCell.swift
//  NYTimes
//
//  Created by IOS Builds on 8/6/19.
//  Copyright © 2019 Sanad Barjawi. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell ,Cellable {
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    func configure(_ object: Configurable?) {
        if let article = object as? ArticleItem {
            titleLabel.text = article.title
            captionLabel.text = article.abstract
            articleImageView.layer.cornerRadius = 25
            articleImageView.kf.setImage(with: URL(string: article.media[0].mediaMetadata[0].url))
        }
    }
    
}
