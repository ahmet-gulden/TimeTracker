//
//  TableItemPresentation.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

/// A presentation struct that has almost all the contents that main view controller could display.
struct MainViewPresentation: Equatable {
    /// A presentation that has all the contents for a single logged time entry.
    struct Entry: Equatable {
        let title: String
        let date: String

        init(loggedTime: LoggedTime) {
            self.title = loggedTime.description
            let dateString = DateFormatter.ttr_standard.string(from: loggedTime.startTime)
            self.date = "\(loggedTime.elapsedSeconds.asSecondsElapsedTime) on \(dateString)"
        }
    }

    /// Entries to be shown on the main view.
    private(set) var entries: [Entry]

    /// A presentation that will be displayed when there is no content to be displayed.
    let emptyStatePresentation: EmptyStatePresentation

    init(entries: [Entry]) {
        let noLogsStatePresentation = EmptyStatePresentation(
            title: "There is no entry logged yet!",
            message: "Start logging your times by adding an entry"
        )
        self.init(entries: entries, emptyStatePresentation: noLogsStatePresentation)
    }

    private init(entries: [Entry], emptyStatePresentation: EmptyStatePresentation) {
        self.entries = entries
        self.emptyStatePresentation = emptyStatePresentation
    }

    public static let loadingPresentation = MainViewPresentation(
        entries: [],
        emptyStatePresentation: EmptyStatePresentation(
            title: "Loading",
            message: "Fetching the previous log entries"
        )
    )

    public static let errorPresentation = MainViewPresentation(
        entries: [],
        emptyStatePresentation: EmptyStatePresentation(
            title: "Error",
            message: "Unable to fetch previously logged entries"
        )
    )

    public mutating func appendingEntry(_ entry: Entry) {
        entries.append(entry)
    }
}
