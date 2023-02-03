//
//  EmptyStateView.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

struct EmptyStatePresentation: Equatable {
    let title: String
    let message: String
}

/// A view that is to be displayed inside table views when there is no content inside it.
final class EmptyStateView: UIStackView {
    /// Presentation of the empty state view.
    var presentation: EmptyStatePresentation {
        didSet {
            titleLabel.text = presentation.title
            messageLabel.text = presentation.message
        }
    }

    private let titleLabel = UILabel()
    private let messageLabel = UILabel()

    init(presentation: EmptyStatePresentation) {
        self.presentation = presentation
        super.init(frame: .zero)

        configureEmptyStateView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configuration

private extension EmptyStateView {
    func configureEmptyStateView() {
        axis = .vertical
        spacing = Global.Margin.vertical
        distribution = .fill
        alignment = .center

        configureTitleLabelIfNecessary()
        configureMessageLabelIfNecessary()
    }

    func configureTitleLabelIfNecessary() {
        titleLabel.text = presentation.title
        titleLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.7
        titleLabel.textAlignment = .center
        addArrangedSubview(titleLabel)
    }

    func configureMessageLabelIfNecessary() {
        messageLabel.text = presentation.message
        messageLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
        messageLabel.numberOfLines = 4
        messageLabel.adjustsFontSizeToFitWidth = true
        messageLabel.minimumScaleFactor = 0.7
        messageLabel.textAlignment = .center
        addArrangedSubview(messageLabel)
    }
}
