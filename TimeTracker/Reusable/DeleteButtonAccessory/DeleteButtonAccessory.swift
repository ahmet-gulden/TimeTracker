//
//  DeleteButtonAccessory.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 3.02.2023.
//

import UIKit

final class DeleteButtonAccessory: MarginedView {
    var deleteButtonTapHandler: (() -> Void)?

    private let button = UIButton(type: .system)

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

private extension DeleteButtonAccessory {

    func configureView() {
        button.setTitle("🗑️", for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped(sender:)), for: .touchUpInside)
        wrapperView.ttr_addSubview(button)
    }
}

// MARK: Actions

private extension DeleteButtonAccessory {
    @objc func deleteButtonTapped(sender: UIButton) {
        deleteButtonTapHandler?()
    }
}
