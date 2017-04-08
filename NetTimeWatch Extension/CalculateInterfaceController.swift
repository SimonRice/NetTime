//
//  CalculateInterfaceController.swift
//  NetTime
//
//  Created by Simon Rice on 01/06/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Foundation
import SwiftDate
import WatchKit

class CalculateInterfaceController: WKInterfaceController {
    @IBOutlet var hourPicker: WKInterfacePicker!
    @IBOutlet var minutePicker: WKInterfacePicker!
    @IBOutlet var afternoonPicker: WKInterfacePicker!

    @IBOutlet var beatsLabel: WKInterfaceLabel!

    @IBAction func hourPickerDidChange(_ value: Int) {
        self.currentHour = value
        if self.is12h && self.currentAfternoon {
            self.currentHour += 12
        }

        self.showTimeInBeats()
    }

    @IBAction func minutePickerDidChange(_ value: Int) {
        self.currentMinue = value
        self.showTimeInBeats()
    }

    @IBAction func afternoonPickerDidChange(_ value: Int) {
        self.currentAfternoon = value != 0
        if self.currentHour < 12 && self.currentAfternoon {
            self.currentHour += 12
        } else if self.currentHour >= 12 && !self.currentAfternoon {
            self.currentHour -= 12
        }

        self.showTimeInBeats()
    }


    fileprivate var currentHour: Int = 0
    fileprivate var currentMinue: Int = 0
    fileprivate var currentAfternoon: Bool = false

    fileprivate var currentDate: Date {
        return (Date().inRegion()
            .startOf(component: .day) + self.currentHour.hours + self.currentMinue.minutes)
            .absoluteTime
    }

    fileprivate lazy var is12h: Bool = {
        let formatString: String = DateFormatter.dateFormat(
            fromTemplate: "j", options: 0, locale: Locale.current
        ) ?? ""
        return formatString.lowercased().contains("a")
    }()

    fileprivate func setupFor24h() {
        let hourItems: [WKPickerItem] = (0..<24).map({
            let item = WKPickerItem()
            item.title = String(format: "%02d", $0)
            return item
        })

        let minuteItems: [WKPickerItem] = (0..<60).map({
            let item = WKPickerItem()
            item.title = String(format: "%02d", $0)
            return item
        })

        self.hourPicker.setItems(hourItems)
        self.minutePicker.setItems(minuteItems)

        self.hourPicker.setSelectedItemIndex(self.currentHour)
        self.minutePicker.setSelectedItemIndex(self.currentMinue)

        self.hourPicker.setRelativeWidth(0.5, withAdjustment: 0)
        self.minutePicker.setRelativeWidth(0.5, withAdjustment: 0)
    }

    fileprivate func setupFor12h() {
        let hourItems: [WKPickerItem] = (0..<12).map({
            let item = WKPickerItem()
            let hour: Int = $0 == 0 ? 12 : $0
            item.title = String(format: "%d", hour)
            return item
        })

        let minuteItems: [WKPickerItem] = (0..<60).map({
            let item = WKPickerItem()
            item.title = String(format: "%02d", $0)
            return item
        })

        self.hourPicker.setItems(hourItems)
        self.minutePicker.setItems(minuteItems)

        self.hourPicker.setRelativeWidth(0.33, withAdjustment: 0)
        self.minutePicker.setRelativeWidth(0.34, withAdjustment: 0)

        self.hourPicker.setSelectedItemIndex(self.currentHour % 12)
        self.minutePicker.setSelectedItemIndex(self.currentMinue)
        self.afternoonPicker.setSelectedItemIndex(self.currentAfternoon ? 1 : 0)

        let afternoonItems: [WKPickerItem] = ["AM", "PM"].map({
            let item = WKPickerItem()
            item.title = $0
            return item
        })

        self.afternoonPicker.setItems(afternoonItems)
        self.afternoonPicker.setSelectedItemIndex(self.currentAfternoon ? 1 : 0)
    }

    fileprivate func showTimeInBeats() {
        self.beatsLabel.setHidden(false)
        self.beatsLabel.setText(String(format: "@%03d .beats", self.currentDate.nearestBeat))
    }

    override func willActivate() {
        super.willActivate()

        self.currentHour = Date().inRegion().hour
        self.currentMinue = Date().inRegion().minute

        self.afternoonPicker.setHidden(!self.is12h)
        if self.is12h {
            self.currentAfternoon = self.currentHour >= 12
            self.setupFor12h()
        } else {
            self.setupFor24h()
        }

        self.showTimeInBeats()
    }
}
