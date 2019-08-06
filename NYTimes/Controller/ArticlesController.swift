//
//  ArticlesController.swift
//  NYTimes
//
//  Created by Sanad Barjawi on 8/6/19.
//  Copyright © 2019 Sanad Barjawi. All rights reserved.
//

import UIKit

class ArticlesController: UIViewController {
    
    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet var errorView: UIView!
    
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
        articlesSection.didSelect = {[weak self] (article, _) in
            let detailsController = ArticleDetailsController.instantiate()
            detailsController.populate(with: article)
            self?.navigationController?.pushViewController(detailsController, animated: true)
        }
    }
    
    deinit {
        presenter.detachView()
    }
    
    @objc func getArticles() {
        presenter.getMostViewed()
    }
    
}

extension ArticlesController: ArticlesView {
    
    func setError(with message: String) {
        errorLabel.text = message
        articlesTableView.backgroundView = errorView
    }
    
    func setSucceeded() {
        articlesTableView.backgroundView = nil
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
