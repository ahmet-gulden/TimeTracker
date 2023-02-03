//
//  UIViewController+Alert.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

extension UIViewController {
    /// Shows an alert.
    /// - Parameters:
    ///   - message: Message of the alert.
    ///   - title: Title of the alert.
    ///   - defaultActionTitle: Default action button title. Defaults to "Done".
    ///   - defaultActionHandler: Default action button handler. Default value of the handler closes the alert.
    ///   - cancelActionTitle: Cancel action button title. Default value is nil. If this value is nil, cancel button is not shown at the alert.
    ///   - cancelActionHandler: Cancel action button handler. Default value of the handler closes the alert.
    func ttr_showAlert(
        withMessage message: String,
        title: String = "",
        defaultActionTitle: String = "Done",
        defaultActionHandler: (() -> Void)? = nil,
        cancelActionTitle: String? = nil,
        cancelActionHandler: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.setValue(
            NSAttributedString(
                string: title,
                attributes: [
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize:  20.0) as Any,
                    NSAttributedString.Key.foregroundColor: UIColor.label
                ]),
            forKey: "attributedTitle"
        )
        alert.setValue(
            NSAttributedString(
                string: message,
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0) as Any,
                    NSAttributedString.Key.foregroundColor: UIColor.label
                ]),
            forKey: "attributedMessage"
        )
        
        alert.view.tintColor = UIColor.systemOrange
        alert.addAction(
            UIAlertAction(
                title: defaultActionTitle,
                style: .default,
                handler: { _ in
                    defaultActionHandler?()
                }
            )
        )
        if let cancelActionTitle = cancelActionTitle {
            alert.addAction(
                UIAlertAction(
                    title: cancelActionTitle,
                    style: .cancel,
                    handler: { _ in
                        cancelActionHandler?()
                    }
                )
            )
        }

        present(alert, animated: true, completion: nil)
    }
}
