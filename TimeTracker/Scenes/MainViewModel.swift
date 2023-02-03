//
//  LoggedTimesViewModel.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import Foundation

enum MainViewStateChange: StateChange {
    case recordingStarted
    case recordingStopped
    case elapsedTimeUpdated
}

final class MainViewModel: ViewModel<MainViewStateChange> {
    /// An object that helps the recording to create a logged time entry.
    private let timerContext: TimerContext

    /// Creates a main view model with given logged time store and timer context.
    /// - Parameter timerContext: An object that helps the recording to create a logged time entry.
    init(timerContext: TimerContext) {
        self.timerContext = timerContext
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
        // TODO store the logged time
    }
}
