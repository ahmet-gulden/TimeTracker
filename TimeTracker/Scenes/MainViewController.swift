//
//  MainViewController.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

/// Main view controller that displays previously logged time entries as well as records new ones.
final class MainViewController: UIViewController {
    private let logEntryView = LogEntryView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
}

// MARK: Prepare the UI

private extension MainViewController {
    func configureView() {
        view.backgroundColor = .systemBackground
        view.keyboardLayoutGuide.followsUndockedKeyboard = true

        configureLogEntryView()
    }

    func configureLogEntryView() {
        logEntryView.layer.borderWidth = 0.0
        logEntryView.layer.shadowRadius = Global.Margin.small
        logEntryView.layer.shadowColor = UIColor.systemFill.cgColor
        logEntryView.layer.shadowOffset = CGSize(width: 0.0, height: -Global.Margin.small)
        logEntryView.layer.shadowOpacity = 0.5
        view.ttr_addSubview(
            logEntryView,
            toSafeAreaLayoutGuide: true,
            topInset: nil,
            bottomInset: nil
        )
        NSLayoutConstraint.activate([
            view.keyboardLayoutGuide.topAnchor.constraint(
                equalTo: logEntryView.bottomAnchor,
                constant: Global.Margin.vertical
            )
        ])
    }
}
