//
//  ComplicationController.swift
//  NetTimeWatch Extension
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import ClockKit
import SwiftDate

extension CLKComplication {
    // swiftlint:disable:next fuction_length
    func timelineEntryForDate(date: NSDate) -> CLKComplicationTimelineEntry? {
        let beats: Float = date.beats
        let template: CLKComplicationTemplate?

        switch self.family {

        case .CircularSmall:
            let modularTemplate = CLKComplicationTemplateCircularSmallStackText()
            modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "@")
            modularTemplate.line2TextProvider = CLKSimpleTextProvider(
                text: String(format: "%03d", Int(beats)))
            template = modularTemplate

        case .ModularLarge:
            let modularTemplate = CLKComplicationTemplateModularLargeTallBody()
            modularTemplate.headerTextProvider = CLKSimpleTextProvider(text: ".beats")
            modularTemplate.bodyTextProvider = CLKSimpleTextProvider(
                text: String(format: "@%03d", Int(beats)))
            modularTemplate.tintColor = UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0)
            template = modularTemplate

        case .ModularSmall:
            let modularTemplate = CLKComplicationTemplateModularSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(
                text: String(format: "%03d", Int(beats)))
            modularTemplate.tintColor = UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0)
            modularTemplate.ringStyle = .Closed
            modularTemplate.fillFraction = beats / 1000.0
            template = modularTemplate

        case .UtilitarianLarge:
            let modularTemplate = CLKComplicationTemplateUtilitarianLargeFlat()
            modularTemplate.textProvider = CLKSimpleTextProvider(
                text: String(format: "@%03d .beats", Int(beats)))
            template = modularTemplate

        case .UtilitarianSmall:
            let modularTemplate = CLKComplicationTemplateUtilitarianSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(
                text: String(format: "@%03d", Int(beats)))
            modularTemplate.ringStyle = .Closed
            modularTemplate.fillFraction = beats / 1000.0
            template = modularTemplate

        }

        if let template = template {
            return CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
        }

        return nil
    }
}


class ComplicationController: NSObject, CLKComplicationDataSource {

    private var earliestDate: NSDate {
        return NSDate() - 100.beats
    }

    private var latestDate: NSDate {
        return NSDate() + 100.beats
    }

    // swiftlint:disable:next line_length
    private func getTimelineEntriesForComplication(complication: CLKComplication, fromDate: NSDate, toDate: NSDate, limit: Int) -> [CLKComplicationTimelineEntry] {

        let startBeats = fromDate.nearestBeat + 1
        var endBeats = toDate.nearestBeat
        if endBeats < startBeats {
            endBeats += 1000
        }

        let bmtz = Region(timeZoneName: TimeZoneName(rawValue: "Europe/Zurich"))
        let midnight = fromDate.startOf(.Day, inRegion: bmtz)
        var entries: [CLKComplicationTimelineEntry] = []
        let comp = complication

        for beat in startBeats...endBeats where entries.count < limit {
            if let entry = comp.timelineEntryForDate(midnight + beat.beats) {
                entries += [entry]
            }
        }

        return entries
    }

    // MARK: - Timeline Configuration

    // swiftlint:disable:next line_length
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward, .Backward])
    }

    // swiftlint:disable:next line_length
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(self.earliestDate)
    }

    // swiftlint:disable:next line_length
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(self.latestDate)
    }

    // swiftlint:disable:next line_length
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }

    // MARK: - Timeline Population

    // swiftlint:disable:next line_length
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {

        let entry = complication.timelineEntryForDate(NSDate())
        handler(entry)
    }

    // swiftlint:disable:next line_length
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {

        // Call the handler with the timeline entries prior to the given date

        let entries = self.getTimelineEntriesForComplication(complication,
            fromDate: self.earliestDate, toDate: date - 1.seconds, limit: limit)
        handler(entries)
    }

    // swiftlint:disable:next line_length
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date

        let entries = self.getTimelineEntriesForComplication(complication,
            fromDate: date + 1.seconds, toDate: self.latestDate, limit: limit)
        handler(entries)
    }

    // MARK: - Update Scheduling

    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        handler(NSDate() + 60.minutes)
    }

    // MARK: - Placeholder Templates

    // swiftlint:disable:next line_length
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {

        let template: CLKComplicationTemplate?
        switch complication.family {
        case .ModularSmall:
            let modularTemplate = CLKComplicationTemplateModularSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "@")
            modularTemplate.tintColor = UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0)
            modularTemplate.ringStyle = .Closed
            modularTemplate.fillFraction = 0.7
            template = modularTemplate

        case .ModularLarge:
            let modularTemplate = CLKComplicationTemplateModularLargeTallBody()
            modularTemplate.headerTextProvider = CLKSimpleTextProvider(text: ".beats")
            modularTemplate.bodyTextProvider = CLKSimpleTextProvider(text: "@---")
            modularTemplate.tintColor = UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0)
            template = modularTemplate

        case .UtilitarianSmall:
            let modularTemplate = CLKComplicationTemplateUtilitarianSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "@---")
            modularTemplate.ringStyle = .Closed
            modularTemplate.fillFraction = 0.7
            template = modularTemplate

        case .UtilitarianLarge:
            let modularTemplate = CLKComplicationTemplateUtilitarianLargeFlat()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "@--- .beats")
            template = modularTemplate

        case .CircularSmall:
            let modularTemplate = CLKComplicationTemplateCircularSmallStackText()
            modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "@")
            modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: "---")
            template = modularTemplate
        }

        handler(template)
    }

    func requestedUpdateDidBegin() {
        CLKComplicationServer.sharedInstance().reloadActiveComplications()
    }
}
