//
//  SlideUpView.swift
//  QuickHatchDesign
//
//  Created by Daniel Koster on 11/5/20.
//

import UIKit

open class SlideUpView: BaseModal {
    
    private var content: UIView = UIView()
    public init(content: UIView) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        translatesAutoresizingMaskIntoConstraints = false
        self.content = content
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func configure(in view: UIView) {
        let constraints = [
                leadingAnchor.constraint(equalTo: view.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.trailingAnchor),
                topAnchor.constraint(equalTo: view.topAnchor),
                bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    public override func show(in view: UIView, dismissable: Bool, animated: Bool) {
        super.show(in: view, dismissable: dismissable, animated: animated)
        addSubview(contentView)
        presentContentView(in: view,animated: animated)
    }
    
    func presentContentView(in view: UIView, animated: Bool) {
        configureContentView(in: view)
        if animated {
            let frame = contentView.frame
            contentView.frame.origin.y += contentView.frame.height + 500
            animate(animation: { [weak self] in
                self?.contentView.frame = frame
            }, completion: nil)
        }
    }
    
    open func configureContentView(in view: UIView) {
        contentView.addSubview(content)
        let constraints = [
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    public override func dismiss(animated: Bool) {
        if animated {
            animate(animation: { [weak self] in
                guard let self = self else { return }
                self.contentView.frame.origin.y += self.contentView.frame.height + 500
            }, completion: { [weak self] finished in
                self?.contentView.removeFromSuperview()
            })
        }
        super.dismiss(animated: animated)
    }
}
