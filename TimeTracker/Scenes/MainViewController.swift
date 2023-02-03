//
//  MainViewController.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

/// Main view controller that displays previously logged time entries as well as records new ones.
final class MainViewController: UIViewController {
    private let viewModel: MainViewModel
    private let logEntryView = LogEntryView()
    private let tableView = UITableView(frame: .zero, style: .grouped)

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        viewModel.setStateChangeHandler { [weak self] change in
            self?.handleStateChange(change)
        }
        viewModel.fetchLoggedTimes()
    }
}

// MARK: Prepare the UI

private extension MainViewController {
    func configureView() {
        view.backgroundColor = .systemBackground
        view.keyboardLayoutGuide.followsUndockedKeyboard = true

        configureTableView()
        configureLogEntryView()
    }

    func configureTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.ttr_registerCellType(TableCell<AccessoriedMarginedView<TitledLabelView, DeleteButtonAccessory>>.self)
        view.ttr_addSubview(tableView, toSafeAreaLayoutGuide: true, bottomInset: nil)
    }

    func configureLogEntryView() {
        logEntryView.layer.borderWidth = 0.0
        logEntryView.layer.shadowRadius = Global.Margin.small
        logEntryView.layer.shadowColor = UIColor.systemFill.cgColor
        logEntryView.layer.shadowOffset = CGSize(width: 0.0, height: -Global.Margin.small)
        logEntryView.layer.shadowOpacity = 0.5
        logEntryView.actionButtonTapHandler = { [weak self] isRecording in
            guard let self else {
                return
            }
            if isRecording {
                self.logEntryView.isRecording = false
                self.viewModel.endRecording()
            } else if self.logEntryView.entryText.isEmpty {
                self.ttr_showAlert(withMessage: "Please enter a description")
            } else {
                self.logEntryView.isRecording = true
                self.viewModel.startRecording(entryText: self.logEntryView.entryText)
            }
        }
        view.ttr_addSubview(
            logEntryView,
            toSafeAreaLayoutGuide: true,
            topInset: nil,
            bottomInset: nil
        )
        NSLayoutConstraint.activate([
            logEntryView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            view.keyboardLayoutGuide.topAnchor.constraint(
                equalTo: logEntryView.bottomAnchor,
                constant: Global.Margin.vertical
            )
        ])
    }
}

// MARK: Handle State Change

private extension MainViewController {
    func handleStateChange(_ change: MainViewStateChange) {
        switch change {
        case .persistedLogsFetching:
            logEntryView.isEnabled = false
            reloadTableView()
        case .logsUpdated:
            logEntryView.isEnabled = true
            reloadTableView()
        case .recordingStarted:
            logEntryView.isRecording = true
        case .recordingStopped:
            logEntryView.entryText = ""
            logEntryView.isRecording = false
        case .elapsedTimeUpdated:
            logEntryView.elapsedTimeText = viewModel.elapsedTimeText
        }
    }
}

// MARK: UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableCell<AccessoriedMarginedView<TitledLabelView, DeleteButtonAccessory>>.ttr_dequeue(
            from: tableView,
            for: indexPath
        )
        let item = viewModel.content.entries[indexPath.row]
        cell.content.content.titleLabel.text = item.title
        cell.content.content.componentView.text = item.date
        cell.content.accessory.deleteButtonTapHandler = { [weak self] in
            self?.viewModel.deleteLoggedTime(at: indexPath.row)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.content.entries.count
    }
}

// MARK: Helpers

private extension MainViewController {
    func reloadTableView() {
        tableView.ttr_emptyStatePresentation = viewModel.content.entries.isEmpty ? viewModel.content.emptyStatePresentation : nil
        tableView.reloadData()
        // Scroll to bottom to see the latest content
        tableView.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: false)
    }
}
