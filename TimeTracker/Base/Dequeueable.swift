//
//  Dequeueable.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

/// This protocol marks the cell it can be dequeueable in table views.
protocol Dequeueable {
}

// MARK: Dequeueing

extension Dequeueable where Self: UITableViewCell & Reusable {
    /// Dequeues self inside given table view.
    /// - Parameters:
    ///   - tableView: Table view.
    ///   - indexPath: Index path of the cell.
    /// - Returns: Dequeued cell.
    static func ttr_dequeue(from tableView: UITableView, for indexPath: IndexPath) -> Self {
        return tableView.dequeueReusableCell(withIdentifier: Self.reuseIdentifier, for: indexPath) as! Self
    }
}

// MARK: Registration

extension UITableView {
    /// Registers type of self to table view.
    /// - Parameter type: Type of self.
    func ttr_registerCellType<T: UITableViewCell & Reusable & Dequeueable>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: type.reuseIdentifier)
    }
}
