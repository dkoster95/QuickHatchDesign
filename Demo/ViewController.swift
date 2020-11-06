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
    @IBAction func slideup(_ sender: Any) {
        let slideUp = SlideUpView()
        slideUp.show()
    }
    
    @IBAction func slidedown(_ sender: Any) {
        let slideDownView = SlideDownView()
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

