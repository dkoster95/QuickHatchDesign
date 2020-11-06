//
//  Views.swift
//  QuickHatchDesign
//
//  Created by Daniel Koster on 11/5/20.
//

import UIKit

public struct Views {
    static func separator(color: UIColor = .lightGray) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
