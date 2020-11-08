//
//  SlideDownView.swift
//  QuickHatchDesign
//
//  Created by Daniel Koster on 11/5/20.
//

import UIKit

open class SlideDownView: BaseModal {
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    open lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public override func show(in view: UIView, dismissable: Bool, animated: Bool) {
        super.show(in: view, dismissable: dismissable, animated: animated)
        addSubview(contentView)
        presentContentView(in: view,animated: animated)
    }

    
    func presentContentView(in view: UIView, animated: Bool) {
        configureContentView(in: view)
        if animated {
            let frame = contentView.frame
            contentView.frame.origin.y -= contentView.frame.height + 500
            animate(animation: { [weak self] in
                self?.contentView.frame.origin.y = frame.origin.y
            }, completion: nil)
        }
    }
    
    open func configureContentView(in view: UIView) {
        let constraints = [
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    public override func dismiss(animated: Bool) {
        if animated {
            animate(animation: { [weak self] in
                guard let self = self else { return }
                self.contentView.frame.origin.y = -self.contentView.frame.height
            }, completion: { [weak self] finished in
                self?.contentView.removeFromSuperview()
                self?.removeFromSuperview()
            })
        }
        super.dismiss(animated: animated)
    }
    
//    private func animate(animation: @escaping () -> (), completion: ((Bool) -> Void)?) {
//        UIView.animate(withDuration: 0.4,
//                       delay: 0,
//                       usingSpringWithDamping: 0.9,
//                       initialSpringVelocity: 0,
//                       options: [.curveEaseInOut, .allowUserInteraction],
//                       animations: animation,
//                       completion: completion)
//    }
}

