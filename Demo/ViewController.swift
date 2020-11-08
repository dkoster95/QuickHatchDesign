//
//  ViewController.swift
//  Demo
//
//  Created by Daniel Koster on 11/5/20.
//

import UIKit
import QuickHatchDesign

class ViewController: UIViewController {
    let itemsStr = ["First item", "Second item", "third item"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 13
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @IBAction func slideup(_ sender: Any) {
        let slideUp = SlideUpView(content: contentView, heightRatio: 0.7)
        slideUp.show()
    }
    
    @IBAction func slidedown(_ sender: Any) {
        let slideDownView = SlideDownView(content: contentView, heightRatio: 0.25)
        slideDownView.show()
    }
    @IBAction func standardActionSheetTap(_ sender: Any) {
        let actionSheet = QHStandardActionSheet(title: NSAttributedString(string: "Title here"))
        let acItems = itemsStr.map { item -> QHActionSheetItem in
            let asi = QHActionSheetItem(title: NSAttributedString(string: item)) {
                print(item)
            }
            return asi
        }
        for item in acItems {
            actionSheet.add(item: item)
        }
        actionSheet.show()
    }
    
}

