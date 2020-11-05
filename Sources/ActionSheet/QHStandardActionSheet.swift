//
//  QHStandardActionSheet.swift
//  QuickHatchDesign
//
//  Created by Daniel Koster on 11/5/20.
//

import UIKit

public struct QHActionSheetItem {
    var title: NSAttributedString?
    var action: (() -> Void)?
    
    public init(title: NSAttributedString?, action: @escaping (() -> Void)) {
        self.title = title
        self.action = action
    }
}

public class QHStandardActionSheet: BaseActionSheet {
    private var items: [QHActionSheetItem] = []
    private let title: NSAttributedString?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
        label.accessibilityIdentifier = "QHActionSheetHeaderTitle"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.accessibilityIdentifier = "QHStandardActionSheetTableView"
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    public init(title: NSAttributedString?) {
        self.title = title
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var height: CGFloat {
        var height: CGFloat = 0
        if title != nil {
            height += 60
        }
        height += 60 * CGFloat(items.count)
        return height
    }
    
    public func add(item: QHActionSheetItem) {
        items.append(item)
    }
    
    public override func configureContentView(in view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        super.configureContentView(in: view)
        let constraints = [
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(items.count * 60))
        ]
        NSLayoutConstraint.activate(constraints)
        titleLabel.attributedText = title
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(tableView)
    }
}

extension QHStandardActionSheet: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = QHStandardActionSheetCell()
        cell.configure(item: items[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        items[indexPath.row].action?()
        dismiss()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
