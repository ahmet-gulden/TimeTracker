//
//  UserDefaultsLoggedTimeStore.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 3.02.2023.
//

import Foundation

final class UserDefaultsLoggedTimeStore: LoggedTimeStore {
    enum LoggedTimeStoreError: Error {
        case unexpectedType
        case decodeError
    }
    
    private let defaults: UserDefaults
    private lazy var encoder = JSONEncoder()
    private lazy var decoder = JSONDecoder()

    init(userDefaults: UserDefaults) {
        self.defaults = userDefaults
    }

    func store(value: [LoggedTime], key: String, completion: ((Bool) -> Void)) {
        guard let data = try? encoder.encode(value) else {
            completion(false)
            return
        }
        defaults.set(data, forKey: key)
        completion(true)
    }

    func fetch(key: String, completion: (([LoggedTime]?, Error?) -> Void)) {
        guard let entry = defaults.value(forKey: key) else {
            // No entry found, so there is no error here.
            completion(nil, nil)
            return
        }
        guard let data = entry as? Data else {
            // Persisted entry is not of expected type, so return an error here.
            completion(nil, LoggedTimeStoreError.unexpectedType)
            return
        }

        guard let decoded = try? decoder.decode([LoggedTime].self, from: data) else {
            // Unable to decode the retrieved data
            completion(nil, LoggedTimeStoreError.decodeError)
            return
        }

        completion(decoded, nil)
    }
}
