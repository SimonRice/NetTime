//
//  AboutViewController.swift
//  NetTime
//
//  Created by Simon Rice on 24/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Eureka
import FontAwesome
import UIKit

class AboutViewController: FormViewController {
    // swiftlint:disable:next function_body_length
    fileprivate func addAuthorSection() {
        self.form +++ Section()
            <<< LabelRow {
                let versionString: String
                if let infoDictionary = Bundle.main.infoDictionary,
                    let bundleVersionString = infoDictionary["CFBundleShortVersionString"] as? String,
                    let buildString = infoDictionary["CFBundleVersion"] as? String {

                    versionString = "v\(bundleVersionString) (\(buildString))"
                } else {
                    versionString = ""
                }

                $0.cellStyle = .subtitle
                $0.title = "NetTime \(versionString)"
                $0.cell.textLabel!.font = UIFont.boldSystemFont(ofSize: 16)
                $0.value = "by Simon Rice"
                $0.cell.accessoryView = UIImageView(image: UIImage(named: "SettingsAppIcon"))
                $0.cell.height = { return 60.0 }
            }
            <<< LabelRow {
                $0.title = "https://www.simonrice.com/"
                $0.cell.accessoryView = UIImageView(
                    image: UIImage.fontAwesomeIcon(name: .globe,
                        textColor: UIColor(red: 0, green: 0.6, blue: 0.3, alpha: 1),
                        size: CGSize(width: 30, height: 30))
                )
                $0.onCellSelection({ (_, _) in
                    UIApplication.shared.openURL(
                        NSURL(string: "https://www.simonrice.com/")! as URL
                    )
                })
            }
            <<< LabelRow {
                $0.title = "@_SimonRice"
                $0.cell.accessoryView = UIImageView(
                    image: UIImage.fontAwesomeIcon(name: .twitter,
                        textColor: UIColor(red: 0.11, green: 0.63, blue: 0.95, alpha: 1),
                        size: CGSize(width: 30, height: 30))
                )
                $0.onCellSelection({ (_, _) in
                    let app = UIApplication.shared
                    let twitterURL = NSURL(string: "twitter:///user?screen_name=_SimonRice")!
                    if app.canOpenURL(twitterURL as URL) {
                        app.openURL(twitterURL as URL)
                    } else {
                        let altURL = NSURL(string: "https://www.twitter.com/_SimonRice")!
                        app.openURL(altURL as URL)
                    }
                })
            }
            <<< LabelRow {
                $0.title = "Rate NetTime"
                $0.cell.accessoryView = UIImageView(
                    image: UIImage.fontAwesomeIcon(name: .star,
                        textColor: UIColor(red:1, green:0.59, blue:0, alpha:1),
                        size: CGSize(width: 30, height: 30))
                )
                $0.onCellSelection({ (_, _) in
//                    PushReview.reviewApp()
                })
        }
    }

    fileprivate func addCreditSection() {
        self.form +++ Section()
            <<< LabelRow {
                $0.cellStyle = .subtitle
                $0.cell.detailTextLabel!.numberOfLines = 0
                $0.title = "Disclaimer"

                // swiftlint:disable:next line_length
                $0.value = "The algorithm used in this app is beased on Swatch Internet Time, as introduced by Swatch Corporation.  Neither this app nor its developer are associated with Swatch Corporation."

                $0.cell.height = { return 100.0 }
            }
            <<< ButtonRow {
                $0.title = "Credits"
                $0.onCellSelection({ (cell, _) in
                    self.performSegue(withIdentifier: "showCredits", sender: cell)
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
