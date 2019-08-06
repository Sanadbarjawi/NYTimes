//
//  ArticleDetailsController.swift
//  NYTimes
//
//  Created by Sanad Barjawi on 8/6/19.
//  Copyright © 2019 Sanad Barjawi. All rights reserved.
//

import UIKit

class ArticleDetailsController: UIViewController {
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!

    private var articleTitle: String?
    private var imageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.articleImageView.kf.setImage(with: URL(string: imageUrl ?? ""))
        self.articleTitleLabel.text = articleTitle
    }
    
    func populate(with article: ArticleItem) {
        imageUrl = article.media.compactMap {$0.mediaMetadata.compactMap {$0.url}[0]}[0]
        articleTitle = article.title
    }
    
    internal static func instantiate() -> ArticleDetailsController {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(self)") as! ArticleDetailsController
     
        return vc
    }
    
}
