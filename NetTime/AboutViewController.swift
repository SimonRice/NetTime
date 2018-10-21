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
                $0.value = "by Simon Rice & Contributors"
                $0.cell.accessoryView = UIImageView(image: UIImage(named: "SettingsAppIcon"))
                $0.cell.height = { return 60.0 }
            }
            <<< LabelRow {
                $0.title = "https://www.simonrice.com/"
                $0.cell.accessoryView = UIImageView(
                    image: UIImage.fontAwesomeIcon(name: .globe, style: .regular,
                        textColor: UIColor(red: 0, green: 0.6, blue: 0.3, alpha: 1),
                        size: CGSize(width: 30, height: 30))
                )
                $0.onCellSelection({ (_, _) in
                    UIApplication.shared.openURL(
                        URL(string: "https://www.simonrice.com/")!
                    )
                })
            }
            <<< LabelRow {
                $0.title = "@_SimonRice"
                $0.cell.accessoryView = UIImageView(
                    image: UIImage.fontAwesomeIcon(name: .twitter, style: .regular,
                        textColor: UIColor(red: 0.11, green: 0.63, blue: 0.95, alpha: 1),
                        size: CGSize(width: 30, height: 30))
                )
                $0.onCellSelection({ (_, _) in
                    let app = UIApplication.shared
                    let twitterURL = URL(string: "twitter:///user?screen_name=_SimonRice")
                    if let twitterURL = twitterURL, app.canOpenURL(twitterURL) {
                        app.openURL(twitterURL)
                    } else {
                        let altURL = URL(string: "https://www.twitter.com/_SimonRice")!
                        app.openURL(altURL)
                    }
                })
            }
            <<< LabelRow {
                $0.title = "View Source"
                $0.cell.accessoryView = UIImageView(
                    image: UIImage.fontAwesomeIcon(name: .github,
                                                   style: .regular,
                                                   textColor: .black,
                                                   size: CGSize(width: 30, height: 30))
                )
                $0.onCellSelection({ (_, _) in
                    UIApplication.shared.openURL(
                        URL(string: "https://www.github.com/simonrice/NetTime")!
                    )
                })
        }
    }

    fileprivate func addLicenseSection() {
        self.form +++ Section()
            <<< LabelRow {
                $0.cellStyle = .subtitle
                $0.cell.detailTextLabel!.numberOfLines = 0
                $0.title = "Disclaimer"

                // swiftlint:disable:next line_length
                $0.value = "The algorithm used in this app is beased on Swatch Internet Time, as introduced by Swatch Corporation.  Neither this app nor its developer are associated with Swatch Corporation."

                $0.cell.height = { return 100.0 }
            }
            <<< LabelRow {
                $0.cellStyle = .subtitle
                $0.cell.detailTextLabel!.numberOfLines = 0
                $0.title = "License (MIT)"

                // swiftlint:disable:next line_length
                $0.value = "Copyright 2016-Present Simon Rice \n\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: \n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. \n\nTHE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
                $0.cell.height = { return 435.0 }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let tableView = self.tableView {
            tableView.backgroundColor = UIColor(red: 0.85, green: 0.95, blue: 0.9, alpha: 1.0)
        }

        self.addAuthorSection()
        self.addLicenseSection()
    }
}
