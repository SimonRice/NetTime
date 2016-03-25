//
//  CreditsViewController.swift
//  NetTime
//
//  Created by Simon Rice on 24/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import SwiftyAcknowledgements

class CreditsViewController: AcknowledgementsTableViewController {

    @IBOutlet var backgroundView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = self.backgroundView.backgroundColor
    }
}
