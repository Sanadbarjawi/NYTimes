//
//  NYTimesService.swift
//  NYTimes
//
//  Created by Sanad Barjawi on 8/6/19.
//  Copyright © 2019 Sanad Barjawi. All rights reserved.
//

import Foundation
class ArticlesService {
    
    enum MostViewedMarker: Int {
        case aWeekAgo = 7
        case aDayAgo = 1
        case monthAgo = 30
    }
    
    let apiHelper = APIHelper()
    
    func mostViewed(marker: MostViewedMarker = .aWeekAgo, completion: @escaping (Result<ArticleModel, Error>) -> Void) {
        apiHelper.request(endPoint: URLPath.mostViewed(mark: marker.rawValue), method: .get) { (data, error) in
            
            if error != nil {
                completion(.failure(error!))
            }
            do {
                guard let data = data else {return}
                let articles = try JSONDecoder().decode(ArticleModel.self, from: data)
                completion(.success(articles))
            } catch {
                
            }
        }
    }
    
}
