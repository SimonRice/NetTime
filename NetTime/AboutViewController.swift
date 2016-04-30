//
//  AboutViewController.swift
//  NetTime
//
//  Created by Simon Rice on 24/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Eureka
import FontAwesome
import PushReview
import UIKit

class AboutViewController: FormViewController {
    // swiftlint:disable:next function_body_length
    private func addAuthorSection() {
        self.form +++ Section()
            <<< LabelRow() {
                let versionString: String
                if let infoDictionary = NSBundle.mainBundle().infoDictionary,
                    bundleVersionString = infoDictionary["CFBundleShortVersionString"] as? String,
                    buildString = infoDictionary["CFBundleVersion"] as? String {

                    versionString = "v\(bundleVersionString) (\(buildString))"
                } else {
                    versionString = ""
                }

                $0.cellStyle = .Subtitle
                $0.title = "NetTime \(versionString)"
                $0.cell.textLabel!.font = UIFont.boldSystemFontOfSize(16)
                $0.value = "by Simon Rice"
                $0.cell.accessoryView = UIImageView(image: UIImage(named: "SettingsAppIcon"))
                $0.cell.height = { return 60.0 }
            }
            <<< LabelRow() {
                $0.title = "https://www.simonrice.com/"
                $0.cell.accessoryView = UIImageView(
                    image: UIImage.fontAwesomeIconWithName(FontAwesome.Globe,
                        textColor: UIColor(red: 0, green: 0.6, blue: 0.3, alpha: 1),
                        size: CGSize(width: 30, height: 30))
                )
                $0.onCellSelection({ (_, _) in
                    UIApplication.sharedApplication().openURL(
                        NSURL(string: "https://www.simonrice.com/")!
                    )
                })
            }
            <<< LabelRow() {
                $0.title = "@_SimonRice"
                $0.cell.accessoryView = UIImageView(
                    image: UIImage.fontAwesomeIconWithName(FontAwesome.Twitter,
                        textColor: UIColor(red: 0.11, green: 0.63, blue: 0.95, alpha: 1),
                        size: CGSize(width: 30, height: 30))
                )
                $0.onCellSelection({ (_, _) in
                    let app = UIApplication.sharedApplication()
                    let twitterURL = NSURL(string: "twitter:///user?screen_name=_SimonRice")!
                    if app.canOpenURL(twitterURL) {
                        app.openURL(twitterURL)
                    } else {
                        let altURL = NSURL(string: "https://www.twitter.com/_SimonRice")!
                        app.openURL(altURL)
                    }
                })
            }
            <<< LabelRow() {
                $0.title = "Rate NetTime"
                $0.cell.accessoryView = UIImageView(
                    image: UIImage.fontAwesomeIconWithName(FontAwesome.Star,
                        textColor: UIColor(red:1, green:0.59, blue:0, alpha:1),
                        size: CGSize(width: 30, height: 30))
                )
                $0.onCellSelection({ (_, _) in
                    PushReview.reviewApp()
                })
        }
    }

    private func addCreditSection() {
        self.form +++ Section()
            <<< LabelRow() {
                $0.cellStyle = .Subtitle
                $0.cell.detailTextLabel!.numberOfLines = 0
                $0.title = "Disclaimer"

                // swiftlint:disable:next line_length
                $0.value = "The algorithm used in this app is beased on Swatch Internet Time, as introduced by Swatch Corporation.  Neither this app nor its developer are associated with Swatch Corporation."

                $0.cell.height = { return 100.0 }
            }
            <<< ButtonRow() {
                $0.title = "Credits"
                $0.onCellSelection({ (cell, _) in
                    self.performSegueWithIdentifier("showCredits", sender: cell)
                })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let tableView = self.tableView {
            tableView.backgroundColor = UIColor(red: 0.85, green: 0.95, blue: 0.9, alpha: 1.0)
        }

        self.addAuthorSection()
        self.addCreditSection()
    }
}
