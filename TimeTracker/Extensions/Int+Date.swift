//
//  Int+Date.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 3.02.2023.
//

import Foundation

extension Int {
    /// Elapsed time representation of the receiver if it is considered as seconds.
    ///
    /// E.g. 10 being '10 seconds' or 75 being '1 minutes 15 seconds'
    var asSecondsElapsedTime: String {
        guard self >= 0 else {
            return ""
        }
        guard self < 24 * 60 * 60 else {
            return "more than 1 day"
        }
        var elapsedTime = ""
        let hours = self / (60 * 60)
        if hours > 0 {
            elapsedTime += "\(hours) hours"
        }
        let remaining = self % (60 * 60)
        let minutes = remaining / 60
        if minutes > 0 {
            if !elapsedTime.isEmpty {
                elapsedTime += " "
            }
            elapsedTime += "\(minutes) minutes"
        }
        let seconds = remaining % 60
        if seconds > 0 {
            if !elapsedTime.isEmpty {
                elapsedTime += " "
            }
            elapsedTime += "\(seconds) seconds"
        }
        return elapsedTime
    }

    /// Pulse time representation of the receiver if it is considered as seconds.
    ///
    /// E.g. 10 being '00:00:10' or 75 being '00:01:15'
    var asSecondsPulseTime: String {
        guard self >= 0 else {
            return ""
        }
        guard self < 24 * 60 * 60 else {
            return "more than 1 day"
        }
        let hours = self / (60 * 60)
        let remaining = self % (60 * 60)
        let minutes = remaining / 60
        let seconds = remaining % 60
        return "\(hours.asTwoDecimalString):\(minutes.asTwoDecimalString):\(seconds.asTwoDecimalString)"
    }
}

private extension Int {
    var asTwoDecimalString: String {
        if self < 10 {
            return "0\(self)"
        }
        return "\(self)"
    }
}
