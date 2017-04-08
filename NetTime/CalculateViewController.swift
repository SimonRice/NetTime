//
//  CalculateViewController.swift
//  NetTime
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Eureka

class CalculateViewController: FormViewController {
    fileprivate var date = Date() {
        didSet {
            self.setBeatsRow()
        }
    }

    fileprivate var timezone: TimeZone = TimeZone.current {
            didSet {
                self.setBeatsRow()
            }
    }

    fileprivate func setBeatsRow() {
        var components = Calendar.current
            .dateComponents([.timeZone, .year, .month, .day, .hour, .minute, .second], from: self.date)
        components.timeZone = self.timezone

        if let beatsRow = self.form.rowBy(tag: "beats") as? LabelRow,
            let date = Calendar.current.date(from: components) {

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

        if ProcessInfo.processInfo.arguments.contains("TEST_MODE"),
            let testTimezone = TimeZone(identifier: "Europe/Zurich") {

            self.timezone = testTimezone
            var components = DateComponents()
            components.year = 2016
            components.month = 1
            components.day = 1
            components.hour = 10
            components.minute = 9

            let testDate = Calendar.current.date(from: components)
            self.date = testDate ?? self.date
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
                $0.value = self.timezone.identifier
                }.onChange { [weak self] row in
                    guard let timezoneValue = row.value,
                        let timezone = TimeZone(identifier: timezoneValue),
                        let strongSelf = self else {
                            return
                    }

                    strongSelf.timezone = timezone
        }

        self.form +++ LabelRow("beats") {
            if let label = $0.cell.textLabel {
                label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
            }
        }

        self.setBeatsRow()
    }
}
