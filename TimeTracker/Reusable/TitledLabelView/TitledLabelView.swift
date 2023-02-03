//
//  TitledLabelView.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

/// A container view with a title which has label inside.
final class TitledLabelView: TitledComponentView<UILabel> {
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

private extension TitledLabelView {

    func configureView() {
        componentView.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
        componentView.numberOfLines = 2
        componentView.adjustsFontSizeToFitWidth = true
        componentView.minimumScaleFactor = 0.7
    }
}
