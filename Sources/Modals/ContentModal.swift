//
//  ContentModal.swift
//  QuickHatchDesign
//
//  Created by Daniel Koster on 11/8/20.
//

import UIKit

open class ContentModal: BaseModal {
    
    var content: UIView = UIView()
    var heightRatio: CGFloat = 0.5
    
    public init(content: UIView, heightRatio: CGFloat = 0.5) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        translatesAutoresizingMaskIntoConstraints = false
        self.content = content
        self.heightRatio = heightRatio
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
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
    
    func animatePresentation() {
    }
    
    func presentContentView(in view: UIView, animated: Bool) {
        configureContentView(in: view)
        if animated {
            animatePresentation()
        }
    }
    
    func configureContentView(in view: UIView) {
        contentView.addSubview(content)
    }
    
    func animateDismissal() {
    }
    
    public override func dismiss(animated: Bool) {
        if animated {
            animateDismissal()
        }
        super.dismiss(animated: animated)
    }
}
