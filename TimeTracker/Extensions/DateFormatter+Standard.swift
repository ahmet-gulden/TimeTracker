//
//  DateFormatter.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import Foundation

extension DateFormatter {
    /// Standard date formatter used in project.
    static var ttr_standard: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()
}
