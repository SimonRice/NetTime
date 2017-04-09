//
//  NetTimeTests.swift
//  NetTimeTests
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Nimble
import XCTest

@testable import NetTime

class BeatsSpec: XCTestCase {
    func testGMT() {
        var components = DateComponents()
        components.timeZone = TimeZone(identifier: "Europe/London")
        components.year = 2015
        components.month = 1
        components.day = 1
        components.hour = 11
        components.minute = 0

        guard let currentDate = Calendar.current.date(from: components) else {
            fail("Unable to create date")
            return
        }

        expect(Int(currentDate.beats)).to(equal(500))
    }

    func testBST() {
        var components = DateComponents()
        components.timeZone = TimeZone(identifier: "Europe/London")
        components.year = 2015
        components.month = 6
        components.day = 1
        components.hour = 11
        components.minute = 0

        guard let currentDate = Calendar.current.date(from: components) else {
            fail("Unable to create date")
            return
        }

        expect(Int(currentDate.beats)).to(equal(458))
    }

    func testNewYork() {
        var components = DateComponents()
        components.timeZone = TimeZone(identifier: "America/New_York")
        components.year = 2015
        components.month = 1
        components.day = 1
        components.hour = 10
        components.minute = 9

        guard let currentDate = Calendar.current.date(from: components) else {
            fail("Unable to create date")
            return
        }

        expect(Int(currentDate.beats)).to(equal(672))
    }

    func testBigUnveil() {
        var components = DateComponents()
        components.timeZone = TimeZone(identifier: "America/Los_Angeles")
        components.year = 2016
        components.month = 6
        components.day = 13
        components.hour = 9
        components.minute = 41

        guard let currentDate = Calendar.current.date(from: components) else {
            fail("Unable to create date")
            return
        }

        expect(Int(currentDate.beats)).to(equal(736))
    }

    func testNoBeatsInLA() {
        var components = DateComponents()
        components.timeZone = TimeZone(identifier: "America/Los_Angeles")
        components.year = 2016
        components.month = 6
        components.day = 13
        components.hour = 16
        components.minute = 1

        guard let currentDate = Calendar.current.date(from: components) else {
            fail("Unable to create date")
            return
        }

        expect(Int(currentDate.beats)).to(equal(0))
    }

    func testOneBeatInLA() {
        var components = DateComponents()
        components.timeZone = TimeZone(identifier: "America/Los_Angeles")
        components.year = 2016
        components.month = 6
        components.day = 13
        components.hour = 16
        components.minute = 2

        guard let currentDate = Calendar.current.date(from: components) else {
            fail("Unable to create date")
            return
        }

        expect(Int(currentDate.beats)).to(equal(1))
    }

    func testLastBeatInLA() {
        var components = DateComponents()
        components.timeZone = TimeZone(identifier: "America/Los_Angeles")
        components.year = 2016
        components.month = 6
        components.day = 13
        components.hour = 15
        components.minute = 59

        guard let currentDate = Calendar.current.date(from: components) else {
            fail("Unable to create date")
            return
        }

        expect(Int(currentDate.beats)).to(equal(999))
    }
}
