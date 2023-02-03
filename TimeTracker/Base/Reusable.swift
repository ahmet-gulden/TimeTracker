//
//  Reusable.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import Foundation

/// This protocol marks conformer that it can be reusable with reuse identifier.
protocol Reusable {
    /// Identifier of the receiver. It is defaults to String representation of receiver.
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
