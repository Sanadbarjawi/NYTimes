//
//  Configuration.swift
//  NYTimes
//
//  Created by Sanad Barjawi on 8/6/19.
//  Copyright © 2019 Sanad Barjawi. All rights reserved.
//

import Foundation

// MARK: - Configurations

private struct Configuration {
    static var APIKey: String {
        return "QnMm9uz0wh8kAHU78G0VEs94epAB8i42"
    }
    
    static var serverURL: String {
        return "https://api.nytimes.com"
    }
}

// MARK: - Paths Handling

protocol Endpoint {
    var path: String { get }
}

enum URLPath {
    case mostViewed(mark: Int)
}

extension URLPath: Endpoint {
    var path: String {
        switch self {
            
        case .mostViewed(let marker): return fullURL("/svc/mostpopular/v2/viewed/\(marker).json?api-key=\(Configuration.APIKey)")
        }
    }
    
    private func fullURL(_ path: String) -> String {
        return String(format: "%@%@", Configuration.serverURL, path)
    }
}
