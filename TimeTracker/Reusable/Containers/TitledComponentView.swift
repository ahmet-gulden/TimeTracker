//
//  TitledContainerView.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

/// A container view with a title.
class TitledComponentView<Component: UIView>: MarginedView  {
    /// Title of the container view.
    let titleLabel = UILabel()

    /// Component of the container view.
    let componentView = Component()

    /// Spacing between title and the component
    var spacing: CGFloat = Global.Margin.vertical {
        didSet {
            guard spacing != oldValue else {
                return
            }
            reloadSpacing()
        }
    }

    /// Stack view to hold both title and the component
    private let stackView = UIStackView()

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

private extension TitledComponentView {

    func configureView() {
        configureStackView()
        reloadSpacing()
    }

    func configureStackView() {
        wrapperView.ttr_addSubview(stackView)
        stackView.axis = .vertical
        configureTitleLabel()
        configureComponentView()
    }

    func configureTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.7
        stackView.addArrangedSubview(titleLabel)
    }

    func configureComponentView() {
        stackView.addArrangedSubview(componentView)
    }
}

// MARK: Helpers

private extension TitledComponentView {

    func reloadSpacing() {
        stackView.spacing = spacing
    }
}
