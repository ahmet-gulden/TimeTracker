//
//  OneSecondPulseTimerContext.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import Foundation

/// An object that helps creating logged time entries.
final class OneSecondPulseTimerContext {
    /// Description text of the logged time entry.
    private(set) var entryText: String?

    /// Time passed in seconds while recording.
    private(set) var elapsedSeconds = 0

    /// Time that the recording has started.
    private(set) var startTime: Date?
    private var timer: Timer?
    private var pulseHandler: (() -> Void)?

    deinit {
        stop()
    }
}

// MARK: TimerContext

extension OneSecondPulseTimerContext: TimerContext {
    /// Starts the timer.
    /// - Parameters:
    ///   - entryText: Description text of the logged time entry.
    ///   - pulseHandler: Handler that is executed each pulse.
    func start(entryText: String, pulseHandler: (() -> Void)?) {
        self.entryText = entryText
        self.pulseHandler = pulseHandler
        self.startTime = Date()
        self.elapsedSeconds = 0
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.elapsedSeconds += 1
            self?.pulseHandler?()
        }
    }

    /// Stops the timer.
    func stop() {
        timer?.invalidate()
    }
}
