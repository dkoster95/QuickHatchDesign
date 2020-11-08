//
//  BaseActionSheet.swift
//  QuickHatchDesign
//
//  Created by Daniel Koster on 11/5/20.
//

import UIKit

private struct ActionSheetConfig {
    static let alpha: CGFloat = 0.6
    struct Animation {
        static let duration = 0.25
        static let delay: TimeInterval = 0
        static let springDamping: CGFloat = 0.9
        static let initialSpring:CGFloat = 0
        static let options: UIView.AnimationOptions = [.curveEaseIn, .allowUserInteraction]
    }
}

open class BaseActionSheet: UIView, Modal {
    
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
        view.alpha = ActionSheetConfig.alpha
        return view
    }()
    
    open lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.layer.cornerRadius = 15
        stackView.backgroundColor = .clear
        stackView.layer.masksToBounds = true
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    open var height: CGFloat {
        return 200
    }
    
    public func show(in view: UIView, dismissable: Bool, animated: Bool) {
        addSubview(backgroundView)
        addSubview(contentStackView)
        view.addSubview(self)
        configure(in: view)
        presentBackgroundView(in: view, dismissable: dismissable,animated: animated)
        presentContentView(in: view,animated: animated)
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
    
    func presentBackgroundView(in view: UIView, dismissable: Bool, animated: Bool) {
        if dismissable {
            configureBackgroundTap()
        }
        configureBackgroundView(in: view)
        if animated {
            backgroundView.alpha = 0
            animate(animation: { [weak self] in
                self?.backgroundView.alpha = ActionSheetConfig.alpha
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
            let frame = contentStackView.frame
            contentStackView.frame.origin.y += contentStackView.frame.height + 100
            animate(animation: { [weak self] in
                self?.contentStackView.frame = frame
            }, completion: nil)
        }
    }
    
    open func configureContentView(in view: UIView) {
        let constraints = [
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentStackView.heightAnchor.constraint(equalToConstant: height),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    public func dismiss(animated: Bool) {
        if animated {
            animate(animation: { [weak self] in
                guard let self = self else { return }
                self.contentStackView.frame.origin.y += self.contentStackView.frame.height + 100
            }, completion: { [weak self] finished in
                self?.contentStackView.removeFromSuperview()
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
        UIView.animate(withDuration: ActionSheetConfig.Animation.duration,
                       delay: ActionSheetConfig.Animation.delay,
                       usingSpringWithDamping: ActionSheetConfig.Animation.springDamping,
                       initialSpringVelocity: ActionSheetConfig.Animation.initialSpring,
                       options: ActionSheetConfig.Animation.options,
                       animations: animation,
                       completion: completion)
    }
}
