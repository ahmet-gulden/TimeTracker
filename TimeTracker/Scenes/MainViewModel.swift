//
//  LoggedTimesViewModel.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import Foundation

enum MainViewStateChange: StateChange {

    case persistedLogsFetching
    case logsUpdated
    case recordingStarted
    case recordingStopped
    case elapsedTimeUpdated
}

private enum Constants {
    static let loggedTimePersistenceKey = "com.assignment.TimeTracker.MainViewModel.loggedTimePersistenceKey"
}

final class MainViewModel: ViewModel<MainViewStateChange> {
    /// An object to fetch and store logged time entries.
    private let loggedTimeStore: LoggedTimeStore

    /// An object that helps the recording to create a logged time entry.
    private let timerContext: TimerContext

    /// Creates a main view model with given logged time store and timer context.
    /// - Parameters:
    ///   - timerContext: An object that helps the recording to create a logged time entry.
    ///   - loggedTimeStore: An object to fetch and store logged time entries.
    init(timerContext: TimerContext, loggedTimeStore: LoggedTimeStore) {
        self.timerContext = timerContext
        self.loggedTimeStore = loggedTimeStore
    }

    private var lastFetchedLogs: [LoggedTime] = [] {
        didSet {
            let entries = lastFetchedLogs.sorted(by: { left, right in
                left.startTime < right.startTime
            }).map { log in
                MainViewPresentation.Entry(loggedTime: log)
            }
            content = MainViewPresentation(entries: entries)
        }
    }

    /// Content to be displayed on the main view.
    private(set) var content: MainViewPresentation = .loadingPresentation {
        didSet {
            emit(.logsUpdated)
        }
    }

    // Elapsed time that passed during the recording.
    private(set) var elapsedTimeText: String = "" {
        didSet {
            emit(.elapsedTimeUpdated)
        }
    }
}

// MARK: Public Methods

extension MainViewModel {
    /// Fetches previously logged time entries.
    func fetchLoggedTimes() {
        emit(.persistedLogsFetching)
        loggedTimeStore.fetch(key: Constants.loggedTimePersistenceKey) { [weak self] persistedLogs, error in
            guard let persistedLogs else {
                if error == nil {
                    self?.content = MainViewPresentation(entries: [])
                } else {
                    self?.content = .errorPresentation
                }
                return
            }
            self?.lastFetchedLogs = persistedLogs
        }
    }

    /// Starts the recording with given description text.
    /// - Parameter entryText: Description text that is entered by the user.
    func startRecording(entryText: String) {
        emit(.recordingStarted)
        elapsedTimeText = 0.asSecondsPulseTime
        timerContext.start(entryText: entryText, pulseHandler: { [weak self] in
            guard let self else {
                return
            }
            self.elapsedTimeText = self.timerContext.elapsedSeconds.asSecondsPulseTime
        })
    }

    /// Ends the recording and stores it to the store.
    func endRecording() {
        emit(.recordingStopped)
        elapsedTimeText = ""
        timerContext.stop()
        guard let startTime = timerContext.startTime, let entryText = timerContext.entryText else {
            return
        }
        let loggedTime = LoggedTime(
            description: entryText,
            startTime: startTime,
            elapsedSeconds: timerContext.elapsedSeconds
        )
        lastFetchedLogs.append(loggedTime)
        loggedTimeStore.store(value: self.lastFetchedLogs, key: Constants.loggedTimePersistenceKey) { _ in
            // For the sake of simplicity, it is assumed that storing never fails.
        }
    }

    /// Deletes the logged time entry from the store.
    /// - Parameter index: Index of the logged time entry.
    func deleteLoggedTime(at index: Int) {
        lastFetchedLogs.remove(at: index)
        loggedTimeStore.store(value: lastFetchedLogs, key: Constants.loggedTimePersistenceKey) { _ in
            // For the sake of simplicity, it is assumed that storing never fails.
        }
    }
}

