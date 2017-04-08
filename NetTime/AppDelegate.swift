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

let Log = XCGLogger.default

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    fileprivate var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }

    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        guard !self.isSimulator else { return true }

        Fabric.with([Crashlytics.self])

        return true
    }
}
