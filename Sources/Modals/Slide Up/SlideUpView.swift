//
//  SlideUpView.swift
//  QuickHatchDesign
//
//  Created by Daniel Koster on 11/5/20.
//

import UIKit

open class SlideUpView: ContentModal {
    
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(content: UIView, heightRatio: CGFloat = 0.5) {
        super.init(content: content, heightRatio: heightRatio)
    }
    
    override func animatePresentation() {
        let frame = contentView.frame
        contentView.frame.origin.y += contentView.frame.height + 500
        animate(animation: { [weak self] in
            self?.contentView.frame = frame
        }, completion: nil)
    }
    
    override func animateDismissal() {
        animate(animation: { [weak self] in
            guard let self = self else { return }
            self.contentView.frame.origin.y += self.contentView.frame.height + 500
        }, completion: { [weak self] finished in
            self?.contentView.removeFromSuperview()
        })
    }
    
    override func configureContentView(in view: UIView) {
        super.configureContentView(in: view)
        let constraints = [
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: heightRatio),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}
