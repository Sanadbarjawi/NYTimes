//
//  ArticlesController.swift
//  NYTimes
//
//  Created by IOS Builds on 8/6/19.
//  Copyright © 2019 Sanad Barjawi. All rights reserved.
//

import UIKit

class ArticlesController: UIViewController {
    private var presenter = ArticlesPresenter(ArticlesService())
    
    @IBOutlet weak var articlesTableView: UITableView!
    private var articlesSection: TableViewSection<ArticleModel, ArticleCell>!
    private var articlesTableViewAdapter: TableViewAdapter!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articlesSection = TableViewSection<ArticleModel, ArticleCell>(items: presenter.getArticlesData())
        
    }
}
