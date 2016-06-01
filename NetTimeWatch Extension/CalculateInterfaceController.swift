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

    private var currentHour: Int = 0
    private var currentMinue: Int = 0
    private var currentAfternoon: Bool = false

    private var currentDate: NSDate {
        return (NSDate().inRegion()
            .startOf(.Day) + self.currentHour.hours + self.currentMinue.minutes)
            .absoluteTime
    }

    private lazy var is12h: Bool = {
        let formatString: String = NSDateFormatter.dateFormatFromTemplate(
            "j", options: 0, locale: NSLocale.currentLocale()
        ) ?? ""
        return formatString.lowercaseString.containsString("a")
    }()

    private func setupFor24h() {
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

    private func setupFor12h() {
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
        self.afternoonPicker.setSelectedItemIndex(Int(self.currentAfternoon))

        let afternoonItems: [WKPickerItem] = ["AM", "PM"].map({
            let item = WKPickerItem()
            item.title = $0
            return item
        })

        self.afternoonPicker.setItems(afternoonItems)
    }

    override func willActivate() {
        super.willActivate()

        self.currentHour = NSDate().inRegion().hour
        self.currentMinue = NSDate().inRegion().minute

        self.afternoonPicker.setHidden(!self.is12h)
        if self.is12h {
            self.currentAfternoon = self.currentHour >= 12
            self.setupFor12h()
        } else {
            self.setupFor24h()
        }
    }
}
