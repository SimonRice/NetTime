//
//  ProcessInfo+TestMode.swift
//  NetTime
//
//  Created by Simon Rice on 07/05/2017.
//  Copyright © 2017 Simon Rice. All rights reserved.
//

import Foundation

extension ProcessInfo {
    static var isTestMode: Bool {
        return processInfo.arguments.contains("TEST_MODE")
    }
}
