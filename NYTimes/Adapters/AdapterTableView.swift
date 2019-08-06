
//
//  AdapterTableView.swift
//  NYTimes
//
//  Created by Sanad Barjawi on 8/5/19.
//  Copyright © 2019 Sanad Barjawi. All rights reserved.
//

import Foundation
import UIKit
protocol Configurable: class {}
protocol CellableDelegate: class {}

/// used to configure cell data and actoins
protocol Cellable {
    func configure(_ object: Configurable?)
    var delegate: CellableDelegate? {get set}
    var indexPath: IndexPath? {get set}
    var itemCount: Int? {get set}
    var section: Int? {get set}
    var identifier: String? {get set}
}

extension Cellable {
    var delegate: CellableDelegate? {
        get { return  nil } set {}
    }
    var section: Int? {
        get { return nil} set {}
    }
    var indexPath: IndexPath? {
        get { return nil} set {}
    }
    var itemCount: Int? {
        get { return nil} set {}
    }
    var identifier: String? {
        get { return nil } set {}
    }
}

protocol ConfigurableSection {
    var count: Int { get }
    var identifier: String {get set}
    var elements: [Configurable] { get }
    var delegate: CellableDelegate? { get }
    func selected(at indexPath: IndexPath)
}
class TableViewHeaderConfig {
    var cell: Cellable.Type
    var model: [Configurable]
    weak var delegate: CellableDelegate?
    
    init(cell: Cellable.Type, model: [Configurable], delegate: CellableDelegate? = nil) {
        self.cell = cell
        self.model = model
        self.delegate = delegate
    }
    
}

class TableViewAdapter: NSObject {
    let sections: [ConfigurableSection]
    var tableViewHeaderConfig: TableViewHeaderConfig?
    var cellHeightsDictionary: [IndexPath: CGFloat] = [:]
    
    init(sections: [ConfigurableSection], tableViewHeaderConfig: TableViewHeaderConfig? = nil ) {
        self.sections = sections
        self.tableViewHeaderConfig = tableViewHeaderConfig
    }
    
}

extension TableViewAdapter: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        guard var cell = tableView.dequeueReusableCell(withIdentifier: section.identifier) as? Cellable & UITableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.delegate = section.delegate
        cell.indexPath = indexPath
        cell.configure(section.elements[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        section.selected(at: indexPath)
    }
    
    // Header Configration
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let config = tableViewHeaderConfig {
            
            guard var cell  = tableView.dequeueReusableCell(withIdentifier: "\(config.cell.self)") as? Cellable & UITableViewCell else {
                return nil
            }
            cell.delegate = config.delegate
            cell.section = section
            cell.configure(config.model[section])
            
            return cell
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cellHeightsDictionary[indexPath] == nil {
            cellHeightsDictionary[indexPath] = cell.frame.size.height
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = self.cellHeightsDictionary[indexPath] {
            return height
        }
        return UITableView.automaticDimension
    }
}

class TableViewSection<Model: Configurable, Cell>: ConfigurableSection where Cell: UITableViewCell & Cellable {
    
    
    weak var delegate: CellableDelegate?
    
    var elements: [Configurable] {
        
        return items
    }
    
    var identifier: String
    
    typealias ModelCellClosure = (Model, IndexPath) -> Void
    
    private var items: [Model]
    
    var didSelect: ModelCellClosure?
    
    var count: Int {
        return items.count
    }
    
    init(items: [Model], delegate: CellableDelegate? = nil) {
        self.items = items
        self.identifier = "\(Cell.self)"
        self.delegate = delegate
    }
    
    func selected(at indexPath: IndexPath) {
        let model = items[indexPath.row]
        didSelect?(model, indexPath)
    }
    
    func updateData(_ items: [Model] ) {
        self.items = items
    }
    
}

extension UITableView {
    func setAdapter(_ adapter: TableViewAdapter) {
        dataSource = adapter
        delegate = adapter
        reloadData()
    }
}
