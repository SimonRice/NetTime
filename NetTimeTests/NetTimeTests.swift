//
//  NetTimeTests.swift
//  NetTimeTests
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Quick
import Nimble

import SwiftDate

@testable import NetTime

class BeatsSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("11AM in London on January 1st 2015") {
            it("should be @500 .beats") {
                var components = DateComponents()
                components.timeZone = TimeZoneName.europeLondon.timeZone
                components.calendar = .current
                components.year = 2015
                components.month = 1
                components.day = 1
                components.hour = 11
                components.minute = 0

                guard let currentDate = DateInRegion(components: components)?.absoluteDate else {
                    fail("Unable to create date")
                    return
                }

                expect(Int(currentDate.beats)).to(equal(500))
            }
        }

        describe("11AM in London on June 1st 2015") {
            it("should be @458 .beats") {
                var components = DateComponents()
                components.timeZone = TimeZoneName.europeLondon.timeZone
                components.calendar = .current
                components.year = 2015
                components.month = 6
                components.day = 1
                components.hour = 11
                components.minute = 0

                guard let currentDate = DateInRegion(components: components)?.absoluteDate else {
                    fail("Unable to create date")
                    return
                }

                expect(Int(currentDate.beats)).to(equal(458))
            }
        }

        describe("10:09AM in New York on January 1st 2015") {
            it("should be @672 .beats") {
                var components = DateComponents()
                components.timeZone = TimeZoneName.americaNewYork.timeZone
                components.calendar = .current
                components.year = 2015
                components.month = 1
                components.day = 1
                components.hour = 10
                components.minute = 9

                guard let currentDate = DateInRegion(components: components)?.absoluteDate else {
                    fail("Unable to create date")
                    return
                }

                expect(Int(currentDate.beats)).to(equal(672))
            }
        }

        describe("9:41AM in California on June 13th 2016") {
            it("should be @736 .beats") {
                var components = DateComponents()
                components.timeZone = TimeZoneName.americaLosAngeles.timeZone
                components.calendar = .current
                components.year = 2016
                components.month = 6
                components.day = 13
                components.hour = 9
                components.minute = 41

                guard let currentDate = DateInRegion(components: components)?.absoluteDate else {
                    fail("Unable to create date")
                    return
                }

                expect(Int(currentDate.beats)).to(equal(736))
            }
        }

        describe("4:01PM in California on June 13th 2016") {
            it("should be @000 .beats") {
                var components = DateComponents()
                components.timeZone = TimeZoneName.americaLosAngeles.timeZone
                components.calendar = .current
                components.year = 2016
                components.month = 6
                components.day = 13
                components.hour = 16
                components.minute = 1

                guard let currentDate = DateInRegion(components: components)?.absoluteDate else {
                    fail("Unable to create date")
                    return
                }

                expect(Int(currentDate.beats)).to(equal(0))
            }
        }

        describe("4:02PM in California on June 13th 2016") {
            it("should be @001 .beats") {
                var components = DateComponents()
                components.timeZone = TimeZoneName.americaLosAngeles.timeZone
                components.calendar = .current
                components.year = 2016
                components.month = 6
                components.day = 13
                components.hour = 16
                components.minute = 2

                guard let currentDate = DateInRegion(components: components)?.absoluteDate else {
                    fail("Unable to create date")
                    return
                }

                expect(Int(currentDate.beats)).to(equal(1))
            }
        }

        describe("3:59PM in California on June 13th 2016") {
            it("should be @999 .beats") {
                var components = DateComponents()
                components.timeZone = TimeZoneName.americaLosAngeles.timeZone
                components.calendar = .current
                components.year = 2016
                components.month = 6
                components.day = 13
                components.hour = 15
                components.minute = 59

                guard let currentDate = DateInRegion(components: components)?.absoluteDate else {
                    fail("Unable to create date")
                    return
                }

                expect(Int(currentDate.beats)).to(equal(999))
            }
        }
    }
}
