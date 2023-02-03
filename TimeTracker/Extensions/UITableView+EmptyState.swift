//
//  UITableView+EmptyState.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

extension UITableView {
    private enum UITableViewEmptyStateKey {
        static var emptyStateViewKey = "com.assignment.TimeTracker.UITableView.emptyStateViewKey"
    }

    private var ttr_emptyStateView: EmptyStateView? {
        get {
            return objc_getAssociatedObject(self, &UITableViewEmptyStateKey.emptyStateViewKey) as? EmptyStateView
        }
        set {
            objc_setAssociatedObject(self, &UITableViewEmptyStateKey.emptyStateViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// A presentation that could be displayed on table views when there is no content in those.
    var ttr_emptyStatePresentation: EmptyStatePresentation? {
        set {
            guard let presentation = newValue else {
                ttr_emptyStateView?.removeFromSuperview()
                ttr_emptyStateView = nil
                return
            }

            guard ttr_emptyStateView == nil else {
                ttr_emptyStateView?.presentation = presentation
                return
            }

            let emptyStateView = EmptyStateView(presentation: presentation)
            emptyStateView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(emptyStateView)
            NSLayoutConstraint.activate([
                emptyStateView.centerXAnchor.constraint(equalTo: centerXAnchor),
                emptyStateView.centerYAnchor.constraint(
                    equalTo: centerYAnchor,
                    constant: -Global.Margin.vertical
                ),
                emptyStateView.topAnchor.constraint(
                    greaterThanOrEqualTo: topAnchor,
                    constant: Global.Margin.vertical
                ),
                emptyStateView.leadingAnchor.constraint(
                    greaterThanOrEqualTo: leadingAnchor,
                    constant: Global.Margin.vertical
                ),
                emptyStateView.trailingAnchor.constraint(
                    lessThanOrEqualTo: trailingAnchor,
                    constant: -Global.Margin.vertical
                ),
                emptyStateView.bottomAnchor.constraint(
                    lessThanOrEqualTo: bottomAnchor,
                    constant: -Global.Margin.vertical
                )
            ])
            ttr_emptyStateView = emptyStateView
        }
        get {
            ttr_emptyStateView?.presentation
        }
    }
}
