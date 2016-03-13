//
//  CalculateViewController.swift
//  NetTime
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Eureka

class CalculateViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.backgroundColor = UIColor(red: 0.85, green: 0.95, blue: 0.9, alpha: 1.0)
        form +++ Section()
            <<< TimeInlineRow() {
                $0.title = "Time of Day"
                $0.value = NSDate()
        }
    }
}
