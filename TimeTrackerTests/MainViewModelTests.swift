//
//  MainViewModelTests.swift
//  TimeTrackerTests
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import XCTest
@testable import TimeTracker

final class MainViewModelTests: XCTestCase {
    func testStoreAndFetching() {
        let timerContext = MockTimerContext()
        let viewModel = MainViewModel(timerContext: timerContext, loggedTimeStore: MockStore())
        viewModel.fetchLoggedTimes()
        assertContent(onViewModel: viewModel, entries: [])

        viewModel.startRecording(entryText: "A")
        timerContext.elapsedSeconds = 5
        viewModel.endRecording()
        assertContent(onViewModel: viewModel, entries: [("A", 5)])

        viewModel.startRecording(entryText: "B")
        timerContext.elapsedSeconds = 3
        viewModel.endRecording()
        assertContent(onViewModel: viewModel, entries: [("A", 5), ("B", 3)])

        viewModel.startRecording(entryText: "C")
        timerContext.elapsedSeconds = 10
        viewModel.endRecording()
        assertContent(onViewModel: viewModel, entries: [("A", 5), ("B", 3), ("C", 10)])

        viewModel.deleteLoggedTime(at: 1)
        assertContent(onViewModel: viewModel, entries: [("A", 5), ("C", 10)])
    }

    func testStateChanges() {
        var allStateChanges: [MainViewStateChange] = []

        let viewModel = MainViewModel(timerContext: MockTimerContext(), loggedTimeStore: MockStore())
        viewModel.setStateChangeHandler {  allStateChanges.append($0) }
        XCTAssertEqual(allStateChanges, [])

        viewModel.fetchLoggedTimes()
        XCTAssertEqual(
            allStateChanges,
            [
                .persistedLogsFetching,
                .logsUpdated,
            ]
        )

        viewModel.startRecording(entryText: "A")
        XCTAssertEqual(
            allStateChanges,
            [
                .persistedLogsFetching,
                .logsUpdated,
                .recordingStarted,
                .elapsedTimeUpdated
            ]
        )

        viewModel.endRecording()
        XCTAssertEqual(
            allStateChanges,
            [
                .persistedLogsFetching,
                .logsUpdated,
                .recordingStarted,
                .elapsedTimeUpdated,
                .recordingStopped,
                .elapsedTimeUpdated,
                .logsUpdated
            ]
        )

        viewModel.deleteLoggedTime(at: 0)
        XCTAssertEqual(
            allStateChanges,
            [
                .persistedLogsFetching,
                .logsUpdated,
                .recordingStarted,
                .elapsedTimeUpdated,
                .recordingStopped,
                .elapsedTimeUpdated,
                .logsUpdated,
                .logsUpdated
            ]
        )
    }
}

private extension MainViewModelTests {
    func assertContent(onViewModel viewModel: MainViewModel, entries: [(String, Int)]) {
        let loggedTimeEntries = entries.map {
            let loggedTime = LoggedTime(
                description: $0.0,
                startTime: Date.distantPast,
                elapsedSeconds: $0.1
            )
            return MainViewPresentation.Entry(loggedTime: loggedTime)
        }
        XCTAssertEqual(viewModel.content, MainViewPresentation(entries: loggedTimeEntries))
    }
}

private final class MockTimerContext: TimerContext {
    private(set) var entryText: String?
    let startTime: Date? = Date.distantPast
    var elapsedSeconds: Int = 0
    func start(entryText: String, pulseHandler: (() -> Void)?) {
        self.entryText = entryText
    }
    func stop() {}
}

private final class MockStore: LoggedTimeStore {
    private var mockArray: [LoggedTime] = []

    func store(value: [LoggedTime], key: String, completion: ((Bool) -> Void)) {
        mockArray = value
        completion(true)
    }

    func fetch(key: String, completion: (([LoggedTime]?, Error?) -> Void)) {
        completion(mockArray, nil)
    }
}
