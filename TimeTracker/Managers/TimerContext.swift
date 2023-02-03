//
//  TimerContext.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import Foundation

/// A protocol to define how logged time recordings should be done.
protocol TimerContext {
    /// Description text of the logged time entry.
    var entryText: String? { get }

    /// Time that the recording has started.
    var startTime: Date? { get }

    /// Time passed in seconds while recording.
    var elapsedSeconds: Int { get }

    /// Starts the timer.
    /// - Parameters:
    ///   - entryText: Description text of the logged time entry.
    ///   - pulseHandler: Handler that is executed each pulse.
    func start(entryText: String, pulseHandler: (() -> Void)?)

    /// Stops the timer.
    func stop()
}
