//
//  CalculateViewController.swift
//  NetTime
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Eureka
import SwiftDate

class CalculateViewController: FormViewController {
    fileprivate var date = Date() {
        didSet {
            self.setBeatsRow()
        }
    }

    fileprivate var timezoneName: TimeZoneName = TimeZoneName(
        rawValue: NSTimeZone.local.identifier)! {
            didSet {
                self.setBeatsRow()
            }
    }

    fileprivate func setBeatsRow() {
        if let beatsRow = self.form.rowBy(tag: "beats") as? LabelRow {
            let region = Region(tz: self.timezoneName.timeZone, cal: .current,
                                loc: .current)
            let midnight = self.date.inRegion(region: region).startOfDay.absoluteDate
            let localMidnight = self.date.inRegion().startOfDay.absoluteDate
            let date = midnight + Int(self.date.timeIntervalSince(localMidnight)).seconds
            beatsRow.title = self.formatBeats(date.beats)
            beatsRow.cell.textLabel!.textAlignment = .center
            beatsRow.updateCell()
        }
    }

    fileprivate func formatBeats(_ beats: Float) -> String {
        return String(format: "@%03d .beats", Int(beats))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if ProcessInfo.processInfo.arguments.contains("TEST_MODE") {
            self.timezoneName = .europeZurich
            var components = DateComponents()
            components.year = 2016
            components.month = 1
            components.day = 1
            components.hour = 10
            components.minute = 9

            if let date = DateInRegion(components: components)?.absoluteDate {
                self.date = date
            }
        }

        if let tableView = self.tableView {
            tableView.backgroundColor = UIColor(red: 0.85, green: 0.95, blue: 0.9, alpha: 1.0)
            tableView.tintColor = UIColor(red: 0.0, green: 0.6, blue: 0.3, alpha: 1.0)
        }

        self.form +++ Section()
            <<< DateTimeInlineRow() {
                $0.title = "Time"
                $0.value = self.date as Date
                }.onChange { [weak self] row in
                    guard let strongSelf = self, let date = row.value else { return }
                    strongSelf.date = date
            }
            <<< PickerInlineRow<String>() {
                $0.title = "Time Zone"
                $0.options = NSTimeZone.knownTimeZoneNames
                $0.value = self.timezoneName.rawValue
                }.onChange { [weak self] row in
                    guard let timezoneValue = row.value,
                        let timezoneName = TimeZoneName(rawValue: timezoneValue),
                        let strongSelf = self else {
                            return
                    }

                    strongSelf.timezoneName = timezoneName
        }

        self.form +++ LabelRow("beats") {
            if let label = $0.cell.textLabel {
                label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
            }
        }

        self.setBeatsRow()
    }
}
