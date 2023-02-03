//
//  AccessoriedMarginedView.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 3.02.2023.
//

import UIKit

/// A container view that has text field inside.
class AccessoriedMarginedView<Content: UIView, Accessory: UIView>: MarginedView {
    private let stackView = UIStackView()
    let content = Content()
    let accessory = Accessory()

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

private extension AccessoriedMarginedView {
    func configureView() {
        stackView.axis = .horizontal
        stackView.spacing = Global.Margin.horizontal
        stackView.alignment = .center
        wrapperView.ttr_addSubview(stackView)

        configureContentView()
        configureAccessoryView()
    }

    func configureContentView() {
        stackView.addArrangedSubview(content)
    }

    func configureAccessoryView() {
        stackView.addArrangedSubview(accessory)
        accessory.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2).isActive = true
    }
}
