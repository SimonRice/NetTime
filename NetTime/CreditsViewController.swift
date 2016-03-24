//
//  CreditsViewController.swift
//  NetTime
//
//  Created by Simon Rice on 24/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import SwiftyMarkdown
import UIKit

class CreditsViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    private var firstLayout: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        let bundle = NSBundle.mainBundle()
        if let textView = self.textView,
            url = bundle.URLForResource("Acknowledgements", withExtension: "md"),
            md = SwiftyMarkdown(url: url) {

            textView.attributedText = md.attributedString()
            textView.textContainerInset = UIEdgeInsetsZero
            textView.scrollIndicatorInsets = UIEdgeInsetsZero
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let textView = self.textView where firstLayout {
            textView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            self.firstLayout = false
        }
    }
}
