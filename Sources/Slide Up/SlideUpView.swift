//
//  SlideUpView.swift
//  QuickHatchDesign
//
//  Created by Daniel Koster on 11/5/20.
//

import UIKit

open class SlideUpView: UIView, Modal {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.6
        return view
    }()
    
    open lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
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
    
    private var keyWindow: UIView? {
        return UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
    }
    
    public func show(dismissable: Bool, animated: Bool) {
        guard let targetView = keyWindow else { return }
        show(in: targetView, dismissable: dismissable, animated: animated)
    }
    
    public func show(in view: UIView, dismissable: Bool, animated: Bool) {
        addSubview(backgroundView)
        addSubview(contentView)
        view.addSubview(self)
        configure(in: view)
        presentBackgroundView(in: view, dismissable: dismissable,animated: animated)
        presentContentView(in: view,animated: animated)
    }
    
    func presentBackgroundView(in view: UIView, dismissable: Bool, animated: Bool) {
        if dismissable {
            configureBackgroundTap()
        }
        configureBackgroundView(in: view)
        if animated {
            backgroundView.alpha = 0
            animate(animation: { [weak self] in
                self?.backgroundView.alpha = 0.6
            }, completion: nil)
        }
    }
    
    private func configureBackgroundView(in view: UIView) {
        let constraints = [
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tap() {
        dismiss(animated: true)
    }
    
    func presentContentView(in view: UIView, animated: Bool) {
        configureContentView(in: view)
        if animated {
            let frame = contentView.frame
            contentView.frame.origin.y += contentView.frame.height + 100
            animate(animation: { [weak self] in
                self?.contentView.frame = frame
            }, completion: nil)
        }
    }
    
    open func configureContentView(in view: UIView) {
        let constraints = [
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    public func dismiss(animated: Bool) {
        if animated {
            animate(animation: { [weak self] in
                guard let self = self else { return }
                self.contentView.frame.origin.y += self.contentView.frame.height + 100
            }, completion: { [weak self] finished in
                self?.contentView.removeFromSuperview()
                self?.removeFromSuperview()
            })
            animate(animation: { [weak self] in
                self?.backgroundView.alpha = 0
            }, completion: { [weak self] finished in
                self?.backgroundView.removeFromSuperview()
            })
        }
    }
    
    private func animate(animation: @escaping () -> (), completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.45,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0,
                       options: [.curveEaseIn, .allowUserInteraction],
                       animations: animation,
                       completion: completion)
    }
}
