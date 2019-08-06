//
//  Extensions.swift
//  NYTimes
//
//  Created by Sanad Barjawi on 8/6/19.
//  Copyright © 2019 Sanad Barjawi. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
extension UIImageView {}

extension UITableView {
    func setAdapter(_ adapter: TableViewAdapter) {
        dataSource = adapter
        delegate = adapter
        reloadData()
    }
    
    func addPullToRefresh(_ controller: UIViewController, _ selector: Selector) {
        let pull = UIRefreshControl()
        pull.addTarget(controller, action: selector, for: .valueChanged)
        self.refreshControl = pull
    }
    
    func endRefreshing() {
        self.refreshControl?.endRefreshing()
    }
    
    func startRefreshing() {
        self.refreshControl?.beginRefreshing()
        let offsetPoint = CGPoint.init(x: 0, y: -(self.refreshControl?.frame.size.height ?? 0))
        self.setContentOffset(offsetPoint, animated: true)
    }
    
}
