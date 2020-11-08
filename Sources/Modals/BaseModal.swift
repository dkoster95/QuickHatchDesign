//
//  BaseModal.swift
//  QuickHatchDesign
//
//  Created by Daniel Koster on 11/7/20.
//

import UIKit

struct ModalConfig {
    struct Animation {
        let duration: Double
        let delay: TimeInterval
        let springDamping: CGFloat
        let inicialVelocity: CGFloat
    }
    let animation: Animation
    let alpha: CGFloat
}


open class BaseModal: UIView, Modal {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var config: ModalConfig {
        return ModalConfig(animation: ModalConfig.Animation(duration: 0.4,
                                                            delay: 0,
                                                            springDamping: 0.9,
                                                            inicialVelocity: 0),
                           alpha: 0.6)
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = config.alpha
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
    
    func animate(animation: @escaping () -> (), completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: config.animation.duration,
                       delay: config.animation.delay,
                       usingSpringWithDamping: config.animation.springDamping,
                       initialSpringVelocity: config.animation.inicialVelocity,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: animation,
                       completion: completion)
    }
    
    private func presentBackgroundView(in view: UIView, dismissable: Bool, animated: Bool) {
        if dismissable {
            configureBackgroundTap()
        }
        configureBackgroundView(in: view)
        if animated {
            backgroundView.alpha = 0
            animate(animation: { [weak self] in
                guard let self = self else { return }
                self.backgroundView.alpha = self.config.alpha
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
    
    deinit {
        print("deiniting modal")
    }
}
