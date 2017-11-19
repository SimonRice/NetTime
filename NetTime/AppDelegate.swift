//
//  AppDelegate.swift
//  NetTime
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Fabric
import Crashlytics
import UIKit
import XCGLogger

// swiftlint:disable:next identifier_name
let Log = XCGLogger.default

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    fileprivate var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }

    // swiftlint:disable:next line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        #if APPSTORE
            if !self.isSimulator {
                Fabric.with([Crashlytics.self])
                UserDefaults.standard.launchCount += 1
            }
        #endif

        return true
    }
}
