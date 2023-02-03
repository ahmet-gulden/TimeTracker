//
//  UIView+Layout.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

extension UIView {
    /// Adds subview to the receiver and places it at the edges of the receiver.
    /// - Parameters:
    ///   - subview: Subview to be added.
    ///   - toSafeAreaLayoutGuide: Flag to determine whether the subview should be docked to safe area layout guide of
    ///   the receiver.
    ///   - topInset: Desired top inset. Defaults to 0.0. If not set the constraint related to it will not be set.
    ///   - leadingInset: Desired leading inset. Defaults to 0.0. If not set the constraint related to it will not be set.
    ///   - trailingInset: Desired trailing inset. Defaults to 0.0. If not set the constraint related to it will not be set.
    ///   - bottomInset: Desired bottom inset. Defaults to 0.0. If not set the constraint related to it will not be set.
    func ttr_addSubview(
        _ subview: UIView,
        toSafeAreaLayoutGuide: Bool = false,
        topInset: CGFloat? = 0.0,
        leadingInset: CGFloat? = 0.0,
        trailingInset: CGFloat? = 0.0,
        bottomInset: CGFloat? = 0.0
    ) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)

        if let topInset {
            subview.topAnchor.constraint(
                equalTo: toSafeAreaLayoutGuide ? safeAreaLayoutGuide.topAnchor : topAnchor,
                constant: topInset
            ).isActive = true
        }

        if let leadingInset {
            subview.leadingAnchor.constraint(
                equalTo: toSafeAreaLayoutGuide ? safeAreaLayoutGuide.leadingAnchor : leadingAnchor,
                constant: leadingInset
            ).isActive = true
        }

        if let trailingInset {
            subview.trailingAnchor.constraint(
                equalTo: toSafeAreaLayoutGuide ? safeAreaLayoutGuide.trailingAnchor : trailingAnchor,
                constant: -trailingInset
            ).isActive = true
        }

        if let bottomInset {
            subview.bottomAnchor.constraint(
                equalTo: toSafeAreaLayoutGuide ? safeAreaLayoutGuide.bottomAnchor : bottomAnchor,
                constant: -bottomInset
            ).isActive = true
        }
    }
}
