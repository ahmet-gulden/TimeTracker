//
//  TableCell.swift
//  TimeTracker
//
//  Created by Ahmet Gülden on 2.02.2023.
//

import UIKit

/// Generic table view cell that has specific content inside.
final class TableCell<Content: UIView>: UITableViewCell, Dequeueable, Reusable {
    /// Content of the table cell.
    let content = Content()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureTableCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureTableCell()
    }
}

// MARK: Configuration

private extension TableCell {
    func configureTableCell() {
        selectionStyle = .none
        backgroundView?.backgroundColor = .clear
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        contentView.ttr_addSubview(
            content,
            topInset: Global.Margin.vertical / 2.0,
            leadingInset: Global.Margin.horizontal,
            trailingInset: Global.Margin.horizontal,
            bottomInset: Global.Margin.vertical / 2.0
        )
    }
}
