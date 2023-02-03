//
//  LoggedTime.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import Foundation

/// An entity that represents a logged time entry.
struct LoggedTime: Codable, Equatable {
    /// Description that is entered by the user.
    let description: String

    /// Time of the recording has started.
    let startTime: Date

    /// Elapsed time during the recording.
    let elapsedSeconds: Int
}
