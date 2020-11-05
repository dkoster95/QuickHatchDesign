//
//  QHStandardActionSheetCell.swift
//  QuickHatchDesign
//
//  Created by Daniel Koster on 11/5/20.
//

import UIKit

class QHStandardActionSheetCell: UITableViewCell {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(item: QHActionSheetItem) {
        contentView.addSubview(label)
        contentView.backgroundColor = .clear
        let separator = Views.separator()
        separator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separator)
        label.attributedText = item.title
        let constraints = [
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.topAnchor.constraint(equalTo: contentView.topAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
