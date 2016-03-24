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
    private var date: NSDate = NSDate() {
        didSet {
            self.setBeatsRow()
        }
    }

    private var timezoneName: TimeZoneName = TimeZoneName(
        rawValue: NSTimeZone.localTimeZone().name)! {
            didSet {
                self.setBeatsRow()
            }
    }

    private func setBeatsRow() {
        if let beatsRow = self.form.rowByTag("beats") as? LabelRow {
            let region = Region(timeZoneName: self.timezoneName)
            let midnight = self.date.startOf(.Day, inRegion: region)
            let localMidnight = self.date.startOf(.Day, inRegion: Region())
            let date = midnight + Int(self.date.timeIntervalSinceDate(localMidnight)).seconds
            beatsRow.title = self.formatBeats(date.beats)
            beatsRow.cell.textLabel!.textAlignment = .Center
            beatsRow.updateCell()
        }
    }

    private func formatBeats(beats: Float) -> String {
        return String(format: "@%03d .beats", Int(beats))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if NSProcessInfo.processInfo().arguments.contains("TEST_MODE") {
            self.date = DateInRegion(year: 2016, month: 1, day: 1,
                                     hour: 10, minute: 09).absoluteTime

            self.timezoneName = TimeZoneName.EuropeZurich
        }

        if let tableView = self.tableView {
            tableView.backgroundColor = UIColor(red: 0.85, green: 0.95, blue: 0.9, alpha: 1.0)
            tableView.tintColor = UIColor(red: 0.0, green: 0.6, blue: 0.3, alpha: 1.0)
        }

        self.form +++ Section()
            <<< DateTimeInlineRow() {
                $0.title = "Time"
                $0.value = self.date
                }.onChange { [weak self] row in
                    if let strongSelf = self, date = row.value {
                        strongSelf.date = date
                    }
            }
            <<< PickerInlineRow<String>() {
                $0.title = "Time Zone"
                $0.options = NSTimeZone.knownTimeZoneNames()
                $0.value = self.timezoneName.rawValue
                }.onChange { [weak self] row in
                    if let strongSelf = self, timezoneName = row.value {
                        strongSelf.timezoneName = TimeZoneName(rawValue: timezoneName)!
                    }
        }

        self.form +++= LabelRow("beats") {
            if let label = $0.cell.textLabel {
                label.font = UIFont.boldSystemFontOfSize(label.font.pointSize)
            }
        }

        self.setBeatsRow()
    }
}
