//
//  AppDelegate.swift
//  NetTime
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Fabric
import Crashlytics
import PushReview
import Siren
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        Fabric.with([Crashlytics.self])

        let siren = Siren.sharedInstance
        siren.checkVersion(.Immediately)

        PushReview.configureWithAppId("1095598506", appDelegate: self)
        PushReview.registerNotificationSettings()
        PushReview.usesBeforePresenting = 10

        return true
    }

    func applicationDidBecomeActive(application: UIApplication) {
        Siren.sharedInstance.checkVersion(.Daily)
    }
}
