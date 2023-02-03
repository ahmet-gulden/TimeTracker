//
//  TextFieldView.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

/// A container view that has text field inside.
final class TextFieldView: TitledComponentView<UITextField> {
    /// Text of the text field.
    var text: String {
        set {
            componentView.text = newValue
        }
        get {
            componentView.text ?? ""
        }
    }

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

private extension TextFieldView {
    func configureView() {
        componentView.backgroundColor = .clear
        componentView.font = UIFont.systemFont(ofSize: 15.0)
        componentView.textColor = UIColor.label
        componentView.autocapitalizationType = .none
    }
}
