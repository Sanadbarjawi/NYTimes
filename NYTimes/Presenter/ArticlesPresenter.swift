//
//  NYTimesArticlesPresenter.swift
//  NYTimes
//
//  Created by IOS Builds on 8/6/19.
//  Copyright © 2019 Sanad Barjawi. All rights reserved.
//

import Foundation

protocol ArticlesView: class {
    func setSucceeded()
    func startLoading()
    func finishLoading()
    func setError(with message: String)
}

class ArticlesPresenter {
    private var articlesService: ArticlesService?
    private weak var articlesView: ArticlesView?
    private var articlesList: [ArticleItem]!
    init(_ service: ArticlesService) {
        self.articlesService = service
    }
    
    func attachView(_ view: ArticlesView) {
        self.articlesView = view
    }
    
    func detachView() {
        self.articlesView = nil
    }
    
    func getMostViewed() {
        articlesView?.startLoading()
        articlesService?.mostViewed(marker: .aDayAgo, completion: { [weak self] result in
            switch result {
            case .success(let articlesModel):
                self?.articlesList = articlesModel.results
                self?.articlesView?.setSucceeded()
                self?.articlesView?.finishLoading()

            case .failure(let error):
                self?.articlesView?.setError(with: error.localizedDescription)
                self?.articlesView?.finishLoading()
            }
        })
    }
    
    func getArticlesData() -> [ArticleItem] {
        return articlesList ?? []
    }
}
