//
//  LogEntryView.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

/// A container view that has text field inside.
final class LogEntryView: AccessoriedMarginedView<TextFieldView, UIStackView> {
    typealias LogEntryActionButtonHandler = (_ isRecording: Bool) -> Void

    private let actionButton = UIButton(type: .roundedRect)

    private let elapsedTimeLabel = UILabel()

    var entryText: String {
        set {
            content.text = newValue
        }
        get {
            content.text
        }
    }

    var isRecording = false {
        didSet {
            updateActionButtonState()
            updateTextFieldViewState()
        }
    }

    var isEnabled = true {
        didSet {
            updateActionButtonState()
            updateTextFieldViewState()
        }
    }

    var elapsedTimeText: String = "" {
        didSet {
            elapsedTimeLabel.text = elapsedTimeText
        }
    }

    var actionButtonTapHandler: LogEntryActionButtonHandler?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureView()
    }
}

// MARK: Configuration

private extension LogEntryView {
    func configureView() {
        configureTextFieldView()
        configureAccessoryView()
    }

    func configureTextFieldView() {
        content.componentView.placeholder = "Type here"
    }

    func configureAccessoryView() {
        accessory.axis = .vertical
        accessory.distribution = .fillEqually
        configureActionButton()
        configureElapsedTimeLabel()
    }

    func configureActionButton() {
        actionButton.setTitle("▶️", for: .normal)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        accessory.addArrangedSubview(actionButton)
    }

    func configureElapsedTimeLabel() {
        elapsedTimeLabel.text = elapsedTimeText
        elapsedTimeLabel.textColor = .systemOrange
        elapsedTimeLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .light)
        elapsedTimeLabel.textAlignment = .center
        accessory.addArrangedSubview(elapsedTimeLabel)
    }
}

// MARK: Helpers

private extension LogEntryView {
    func updateActionButtonState() {
        actionButton.setTitle(isRecording ? "⏺️" : "▶️", for: .normal)
        actionButton.isEnabled = isEnabled
    }

    func updateTextFieldViewState() {
        let isTextFieldEnabled = !isRecording && isEnabled
        content.titleLabel.text = isRecording ? "Recording" : "What are you working on?"
        content.titleLabel.textColor = isTextFieldEnabled ? .label : .secondaryLabel
        content.componentView.isEnabled = isTextFieldEnabled
        content.backgroundColor = isTextFieldEnabled ? nil : .secondarySystemBackground
    }

    @objc func actionButtonTapped() {
        actionButtonTapHandler?(isRecording)
    }
}
