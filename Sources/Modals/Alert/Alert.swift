//
//  Alert.swift
//  QuickHatchDesign
//
//  Created by Daniel Koster on 11/8/20.
//

import UIKit

public class Alert: BaseModal {
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var content: UIView = UIView()
    private var heightRatio: CGFloat = 0.5
    public init(content: UIView, heightRatio: CGFloat = 0.5) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        translatesAutoresizingMaskIntoConstraints = false
        self.content = content
        self.heightRatio = heightRatio
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func show(in view: UIView, dismissable: Bool, animated: Bool) {
        super.show(in: view, dismissable: dismissable, animated: animated)
    }
    
    
    
    public override func dismiss(animated: Bool) {
        if animated {
            animate(animation: {
                
            }, completion: { finished in
                
            })
        }
        super.dismiss(animated: animated)
    }
}
