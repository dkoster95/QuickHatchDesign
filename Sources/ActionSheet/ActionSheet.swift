//
//  ActionSheet.swift
//  QuickHatchDesign
//
//  Created by Daniel Koster on 11/5/20.
//

import UIKit

public protocol ActionSheet {
    func show(in view: UIView, dismissable: Bool, animated: Bool)
    func show(dismissable: Bool, animated: Bool)
    func dismiss(animated: Bool)
}

public extension ActionSheet {
    
    func show(in view: UIView, dismissable: Bool = true, animated: Bool = true) {
        show(in: view, dismissable: dismissable, animated: animated)
    }
    
    func show(dismissable: Bool = true, animated: Bool = true) {
        show(dismissable: dismissable, animated: animated)
    }
    
    func dismiss(animated: Bool = true) {
        dismiss(animated: animated)
    }
    
}
