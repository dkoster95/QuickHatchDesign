//
//  BaseModal.swift
//  QuickHatchDesign
//
//  Created by Daniel Koster on 11/7/20.
//

import UIKit


public class BaseModal: UIView, Modal {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.6
        return view
    }()
    
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
    
    private func animate(animation: @escaping () -> (), completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: animation,
                       completion: completion)
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
//        addSubview(contentStackView)
        view.addSubview(self)
        configure(in: view)
        presentBackgroundView(in: view, dismissable: dismissable,animated: animated)
    }
    
    public func dismiss(animated: Bool) {
        if animated {
            animate(animation: { [weak self] in
                self?.backgroundView.alpha = 0
            }, completion: { [weak self] finished in
                self?.backgroundView.removeFromSuperview()
                self?.removeFromSuperview()
            })
        }
    }
}
