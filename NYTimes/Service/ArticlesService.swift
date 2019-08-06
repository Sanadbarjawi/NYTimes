//
//  NYTimesService.swift
//  NYTimes
//
//  Created by IOS Builds on 8/6/19.
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
    
    func mostViewed(marker: MostViewedMarker = .aWeekAgo) {
        apiHelper.request(endPoint: URLPath.mostViewed(mark: marker.rawValue), method: .get) { (data, error) in
            
        }
    }
    
}
