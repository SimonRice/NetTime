//
//  UserDefaults+Properties.swift
//  NetTime
//
//  Created by Simon Rice on 10/05/2017.
//  Copyright © 2017 Simon Rice. All rights reserved.
//

import Foundation

extension UserDefaults {
    var launchCount: Int {
        get { return integer(forKey: #function) }
        set { return set(newValue, forKey: #function) }
    }
}
