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
        static let options: UIView.AnimationOptions = [.curveEaseInOut, .allowUserInteraction]
    }
}

open class BaseActionSheet: BaseModal {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
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
    
    open override var config: ModalConfig {
        return ModalConfig(animation: ModalConfig.Animation(duration: ActionSheetConfig.Animation.duration,
                                                            delay: ActionSheetConfig.Animation.delay,
                                                            springDamping: ActionSheetConfig.Animation.springDamping,
                                                            inicialVelocity: ActionSheetConfig.Animation.initialSpring),
                           alpha: ActionSheetConfig.alpha)
    }
    
    public override func show(in view: UIView, dismissable: Bool, animated: Bool) {
        super.show(in: view, dismissable: dismissable, animated: animated)
        addSubview(contentStackView)
        presentContentView(in: view,animated: animated)
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
    
    public override func dismiss(animated: Bool) {
        if animated {
            animate(animation: { [weak self] in
                guard let self = self else { return }
                self.contentStackView.frame.origin.y += self.contentStackView.frame.height + 100
            }, completion: { [weak self] finished in
                self?.contentStackView.removeFromSuperview()
                self?.removeFromSuperview()
            })
        }
        super.dismiss(animated: animated)
    }
    
}
