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
}

class ArticlesPresenter {
    private var articlesService: ArticlesService?
    private weak var articlesView: ArticlesView?
    private var articlesList: [ArticleModel]!
    init(_ service: ArticlesService) {
        self.articlesService = service
    }
    
    func attachView(_ view: ArticlesView) {
        self.articlesView = view
    }
    
    func detachView() {
        self.articlesView = nil
    }
    
    func getArticles() {
        articlesService?.mostViewed()
    }
    
    func getArticlesData() -> [ArticleModel] {
        return articlesList ?? []
    }
}
