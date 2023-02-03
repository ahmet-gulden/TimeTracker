//
//  Persistence.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import Foundation

// Protocol to fetch and store logged time entries.
protocol LoggedTimeStore {
    /// Stores the values with given key.
    /// - Parameters:
    ///   - value: Values to be stored.
    ///   - key: Key to be mapped with these values.
    ///   - completion: Handler to be executed when these values are stored.
    func store(value: [LoggedTime], key: String, completion: ((Bool) -> Void))

    /// Fetches the values with given key.
    /// - Parameters:
    ///   - key: Mapped key that correspond to stored values.
    ///   - completion: Handler to be executed when these values are fetched.
    func fetch(key: String, completion: (([LoggedTime]?, Error?) -> Void))
}

