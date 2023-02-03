//
//  MarginedView.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

/// A wrapper view that has background color and has margins to its subviews.
class MarginedView: UIView {
    /// Container view that holds subviews.
    let wrapperView = UIView()

    /// Horizontal margin of the container view.
    var horizontalMargin: CGFloat = Global.Margin.horizontal {
        didSet {
            guard horizontalMargin != oldValue else {
                return
            }
            reloadHorizontalConstraints()
        }
    }

    /// Vertical margin of the container view.
    var verticalMargin: CGFloat = Global.Margin.vertical {
        didSet {
            guard verticalMargin != oldValue else {
                return
            }
            reloadVerticalConstraints()
        }
    }

    private var containerViewTopConstraint: NSLayoutConstraint?
    private var containerViewLeadingConstraint: NSLayoutConstraint?
    private var containerViewTrailingConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
    
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

private extension MarginedView {
    func configureView() {
        layer.borderWidth = 1.0
        layer.cornerRadius = 8.0
        layer.borderColor = UIColor.secondarySystemFill.cgColor
        backgroundColor = UIColor.systemBackground

        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(wrapperView)

        containerViewLeadingConstraint = wrapperView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: horizontalMargin
        )
        containerViewTrailingConstraint = wrapperView.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -horizontalMargin
        )
        containerViewTopConstraint = wrapperView.topAnchor.constraint(
            equalTo: topAnchor,
            constant: verticalMargin
        )
        containerViewBottomConstraint = wrapperView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -verticalMargin
        )

        [containerViewLeadingConstraint,
         containerViewTrailingConstraint,
         containerViewTopConstraint,
         containerViewBottomConstraint].forEach { $0?.isActive = true }
    }
}

// MARK: Helpers

private extension MarginedView {
    func reloadHorizontalConstraints() {
        containerViewLeadingConstraint?.constant = horizontalMargin
        containerViewTrailingConstraint?.constant = -horizontalMargin
    }

    func reloadVerticalConstraints() {
        containerViewTopConstraint?.constant = verticalMargin
        containerViewBottomConstraint?.constant = -verticalMargin
    }
}
