//
//  ArticlesController.swift
//  NYTimes
//
//  Created by IOS Builds on 8/6/19.
//  Copyright © 2019 Sanad Barjawi. All rights reserved.
//

import UIKit

class ArticlesController: UIViewController {
    
    @IBOutlet weak var articlesTableView: UITableView!
    
    private var presenter = ArticlesPresenter(ArticlesService())
    private var articlesSection: TableViewSection<ArticleItem, ArticleCell>!
    private var articlesTableViewAdapter: TableViewAdapter!
    override func viewDidLoad() {
        super.viewDidLoad()
        articlesTableView.tableFooterView = UIView()
        articlesTableView.addPullToRefresh(self, #selector(getArticles))
        articlesSection = TableViewSection<ArticleItem, ArticleCell>(items: presenter.getArticlesData())
        articlesTableViewAdapter = TableViewAdapter(sections: [articlesSection])
        articlesTableView.setAdapter(articlesTableViewAdapter)
        presenter.attachView(self)
        presenter.getMostViewed()
    }
    
    @objc func getArticles() {
        presenter.getMostViewed()
    }
    
}

extension ArticlesController: ArticlesView {
    
    func setError(with message: String) {
        
    }
    
    func setSucceeded() {
        articlesSection.updateData(presenter.getArticlesData())
        articlesTableView.reloadData()
    }
    
    func startLoading() {
        articlesTableView.startRefreshing()
    }
    
    func finishLoading() {
        articlesTableView.endRefreshing()
    }
    
}
