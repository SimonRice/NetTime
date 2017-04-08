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
    // swiftlint:disable:next function_length
    func timelineEntryForDate(_ date: Date) -> CLKComplicationTimelineEntry? {
        let beats: Float = date.beats
        let template: CLKComplicationTemplate?

        switch self.family {

        case .circularSmall:
            let modularTemplate = CLKComplicationTemplateCircularSmallStackText()
            modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "@")
            modularTemplate.line2TextProvider = CLKSimpleTextProvider(
                text: String(format: "%03d", Int(beats)))
            template = modularTemplate

        case .modularLarge:
            let modularTemplate = CLKComplicationTemplateModularLargeTallBody()
            modularTemplate.headerTextProvider = CLKSimpleTextProvider(text: ".beats")
            modularTemplate.bodyTextProvider = CLKSimpleTextProvider(
                text: String(format: "@%03d", Int(beats)))
            modularTemplate.tintColor = UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0)
            template = modularTemplate

        case .modularSmall:
            let modularTemplate = CLKComplicationTemplateModularSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(
                text: String(format: "%03d", Int(beats)))
            modularTemplate.tintColor = UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0)
            modularTemplate.ringStyle = .closed
            modularTemplate.fillFraction = beats / 1000.0
            template = modularTemplate

        case .utilitarianLarge:
            let modularTemplate = CLKComplicationTemplateUtilitarianLargeFlat()
            modularTemplate.textProvider = CLKSimpleTextProvider(
                text: String(format: "@%03d .beats", Int(beats)))
            template = modularTemplate

        case .utilitarianSmall:
            let modularTemplate = CLKComplicationTemplateUtilitarianSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(
                text: String(format: "%03d", Int(beats)))
            modularTemplate.ringStyle = .closed
            modularTemplate.fillFraction = beats / 1000.0
            template = modularTemplate

        default: return nil
        }

        if let template = template {
            return CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
        }

        return nil
    }
}


class ComplicationController: NSObject, CLKComplicationDataSource {

    fileprivate var earliestDate: Date {
        return Date() - 100.beats
    }

    fileprivate var latestDate: Date {
        return Date() + 100.beats
    }

    // swiftlint:disable:next line_length
    fileprivate func getTimelineEntriesForComplication(_ complication: CLKComplication, fromDate: Date, toDate: Date, limit: Int) -> [CLKComplicationTimelineEntry] {

        var entries: [CLKComplicationTimelineEntry] = []
        let comp = complication

        for i in 1...100 where entries.count < limit && fromDate + i.beats <= toDate {
            if let entry = comp.timelineEntryForDate(fromDate + i.beats) {
                entries += [entry]
            }
        }

        return entries
    }

    // MARK: - Timeline Configuration

    // swiftlint:disable:next line_length
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }

    // swiftlint:disable:next line_length
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(self.earliestDate)
    }

    // swiftlint:disable:next line_length
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(self.latestDate)
    }

    // swiftlint:disable:next line_length
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population

    // swiftlint:disable:next line_length
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: (@escaping (CLKComplicationTimelineEntry?) -> Void)) {

        let entry = complication.timelineEntryForDate(Date())
        handler(entry)
    }

    // swiftlint:disable:next line_length
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {

        // Call the handler with the timeline entries prior to the given date

        let entries = self.getTimelineEntriesForComplication(complication,
            fromDate: self.earliestDate, toDate: date - 1.seconds, limit: limit)
        handler(entries)
    }

    // swiftlint:disable:next line_length
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date

        let entries = self.getTimelineEntriesForComplication(complication,
            fromDate: date + 1.seconds, toDate: self.latestDate, limit: limit)
        handler(entries)
    }

    // MARK: - Update Scheduling

    func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
        handler(Date() + 60.minutes)
    }

    // MARK: - Placeholder Templates

    // swiftlint:disable:next line_length
    func getPlaceholderTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {

        let template: CLKComplicationTemplate?
        switch complication.family {
        case .modularSmall:
            let modularTemplate = CLKComplicationTemplateModularSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "@")
            modularTemplate.tintColor = UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0)
            modularTemplate.ringStyle = .closed
            modularTemplate.fillFraction = 0.7
            template = modularTemplate

        case .modularLarge:
            let modularTemplate = CLKComplicationTemplateModularLargeTallBody()
            modularTemplate.headerTextProvider = CLKSimpleTextProvider(text: ".beats")
            modularTemplate.bodyTextProvider = CLKSimpleTextProvider(text: "@---")
            modularTemplate.tintColor = UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0)
            template = modularTemplate

        case .utilitarianSmall:
            let modularTemplate = CLKComplicationTemplateUtilitarianSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "@")
            modularTemplate.ringStyle = .closed
            modularTemplate.fillFraction = 0.7
            template = modularTemplate

        case .utilitarianLarge:
            let modularTemplate = CLKComplicationTemplateUtilitarianLargeFlat()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "@--- .beats")
            template = modularTemplate

        case .circularSmall:
            let modularTemplate = CLKComplicationTemplateCircularSmallStackText()
            modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "@")
            modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: "---")
            template = modularTemplate

        default: template = nil

        }

        handler(template)
    }

    func requestedUpdateDidBegin() {
        CLKComplicationServer.sharedInstance().reloadActiveComplications()
    }
}
