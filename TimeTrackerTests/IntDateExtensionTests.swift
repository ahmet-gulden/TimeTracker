//
//  IntDateExtensionTests.swift
//  TimeTrackerTests
//
//  Created by Ahmet Gülden on 3.02.2023.
//

import XCTest
@testable import TimeTracker

final class IntDateExtensionTests: XCTestCase {

    func testElapsedTime() {
        XCTAssertEqual(12522.asSecondsPulseTime, "03:28:42")
        XCTAssertEqual(3002.asSecondsPulseTime, "00:50:02")
        XCTAssertEqual(2405.asSecondsPulseTime, "00:40:05")
        XCTAssertEqual((-1).asSecondsPulseTime, "")
        XCTAssertEqual(60.asSecondsPulseTime, "00:01:00")
        XCTAssertEqual(10.asSecondsPulseTime, "00:00:10")
    }

    func testPulseTime() {
        XCTAssertEqual(12522.asSecondsElapsedTime, "3 hours 28 minutes 42 seconds")
        XCTAssertEqual(3002.asSecondsElapsedTime, "50 minutes 2 seconds")
        XCTAssertEqual(2405.asSecondsElapsedTime, "40 minutes 5 seconds")
        XCTAssertEqual((-1).asSecondsElapsedTime, "")
        XCTAssertEqual(60.asSecondsElapsedTime, "1 minutes")
        XCTAssertEqual(10.asSecondsElapsedTime, "10 seconds")
    }
}
