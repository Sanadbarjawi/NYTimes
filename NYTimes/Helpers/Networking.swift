//
//  Networking.swift
//  answer
//
//  Created by Ahmad Almasri on 6/19/18.
//  Copyright © 2018 Genie9. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkingCompletionHandler = (Data?, Swift.Error?) -> Void

protocol Networking {
    var sessionManager: Session? {get set}

    func request(endPoint: Endpoint, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, callback: @escaping NetworkingCompletionHandler) 
}

var noInternetConnection: Bool {
    return !(NetworkReachabilityManager()?.isReachable ?? true)
}

extension Networking {
    
    func request(endPoint: Endpoint, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, callback: @escaping NetworkingCompletionHandler) {

        guard let url = URL(string: endPoint.path) else {
            return
        }

        sessionManager?.request(url, method: method, parameters: parameters,
                                headers: headers).validate(statusCode: 200...299)
            .responseJSON{ response in
                callback(response.data, response.error)
        }
    }

}
class APIHelper: Networking {
    
    var sessionManager: Session? = Alamofire.Session.default

    init() {
        
        // create a custom session configuration
        let configuration = URLSessionConfiguration.default
        
        // add time out request
        configuration.timeoutIntervalForRequest = 300

        // create a session manager with the configuration
        self.sessionManager = Alamofire.Session(configuration: configuration)

    }
}
