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
    func timelineEntryForDate(date: NSDate) -> CLKComplicationTimelineEntry? {
        let beats: Float = date.beats
        let template: CLKComplicationTemplate?

        switch self.family {

        case .CircularSmall:
            let modularTemplate = CLKComplicationTemplateCircularSmallStackText()
            modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "@")
            modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: String(format: "%03d", Int(beats)))
            template = modularTemplate

        case .ModularLarge:
            let modularTemplate = CLKComplicationTemplateModularLargeTallBody()
            modularTemplate.headerTextProvider = CLKSimpleTextProvider(text: "Beats")
            modularTemplate.bodyTextProvider = CLKSimpleTextProvider(text: String(format: "@%03d", Int(beats)))
            modularTemplate.tintColor = UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0)
            template = modularTemplate

        case .ModularSmall:
            let modularTemplate = CLKComplicationTemplateModularSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: String(format: "%03d", Int(beats)))
            modularTemplate.tintColor = UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0)
            modularTemplate.ringStyle = .Closed
            modularTemplate.fillFraction = beats / 1000.0
            template = modularTemplate

        case .UtilitarianLarge:
            let modularTemplate = CLKComplicationTemplateUtilitarianLargeFlat()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: String(format: "@%03d Beats", Int(beats)))
            template = modularTemplate

        case .UtilitarianSmall:
            let modularTemplate = CLKComplicationTemplateUtilitarianSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: String(format: "@%03d", Int(beats)))
            modularTemplate.ringStyle = .Closed
            modularTemplate.fillFraction = beats / 1000.0
            template = modularTemplate

        }

        if let template = template {
            let timelineEntry = CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
            return timelineEntry
        } else {
            return nil
        }
    }
}


class ComplicationController: NSObject, CLKComplicationDataSource {

    private var earliestDate: NSDate {
        return NSDate() - 50.beats
    }

    private var latestDate: NSDate {
        return NSDate() + 50.beats
    }

    private func getTimelineEntriesForComplication(complication: CLKComplication, fromDate: NSDate, toDate: NSDate, limit: Int) -> [CLKComplicationTimelineEntry] {

        let fromDateSeconds = fromDate.timeIntervalSinceReferenceDate
        let toDateSeconds = toDate.timeIntervalSinceReferenceDate
        let step = (toDateSeconds - fromDateSeconds) / Double(limit)
        var entries: [CLKComplicationTimelineEntry] = []
        var i = fromDateSeconds

        while i < toDateSeconds {
            if let entry = complication.timelineEntryForDate(NSDate(timeIntervalSinceReferenceDate: i))
                where entries.count < 100 {

                    entries += [entry]
            }
            
            i += step
        }

        return entries
    }

    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward, .Backward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(self.earliestDate)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(self.latestDate)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {

        let entry = complication.timelineEntryForDate(NSDate())
        handler(entry)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {

        // Call the handler with the timeline entries prior to the given date

        let entries: [CLKComplicationTimelineEntry] = self.getTimelineEntriesForComplication(complication, fromDate: self.earliestDate, toDate: date, limit: limit)
        handler(entries)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date

        let entries: [CLKComplicationTimelineEntry] = self.getTimelineEntriesForComplication(complication, fromDate: date + 1.seconds, toDate: self.latestDate, limit: limit)
        handler(entries)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        handler(NSDate(timeIntervalSinceNow: 60))
    }
    
    // MARK: - Placeholder Templates
    
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
            modularTemplate.headerTextProvider = CLKSimpleTextProvider(text: "Beats")
            modularTemplate.bodyTextProvider = CLKSimpleTextProvider(text: "@")
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
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "@--- Beats")
            template = modularTemplate

        case .CircularSmall:
            let modularTemplate = CLKComplicationTemplateCircularSmallStackText()
            modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "@")
            modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: "---")
            template = modularTemplate
        }

        handler(template)
    }
}
