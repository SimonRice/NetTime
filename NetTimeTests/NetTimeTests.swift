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
    override func spec() {
        describe("11AM in London on January 1st 2015") {
            it("should be @500 .beats") {
                let region = Region(timeZoneName: TimeZoneName.EuropeLondon)
                let currentDate = DateInRegion(year: 2015, month: 1,
                                               day: 1, hour: 11, minute: 0,
                                               region: region).absoluteTime

                expect(Int(currentDate.beats)).to(equal(500))
            }
        }

        describe("11AM in London on June 1st 2015") {
            it("should be @458 .beats") {
                let region = Region(timeZoneName: TimeZoneName.EuropeLondon)
                let currentDate = DateInRegion(year: 2015, month: 6,
                                               day: 1, hour: 11, minute: 0,
                                               region: region).absoluteTime

                expect(Int(currentDate.beats)).to(equal(458))
            }
        }

        describe("10:09AM in New York on January 1st 2015") {
            it("should be @672 .beats") {
                let region = Region(timeZoneName: TimeZoneName.AmericaNewYork)
                let currentDate = DateInRegion(year: 2015, month: 1,
                                               day: 1, hour: 10, minute: 9,
                                               region: region).absoluteTime

                expect(Int(currentDate.beats)).to(equal(672))
            }
        }

        describe("9:41AM in California on June 13th 2016") {
            it("should be @736 .beats") {
                let region = Region(timeZoneName: TimeZoneName.AmericaLosAngeles)
                let currentDate = DateInRegion(year: 2016, month: 6,
                                               day: 13, hour: 9, minute: 41,
                                               region: region).absoluteTime

                expect(Int(currentDate.beats)).to(equal(736))
            }
        }

        describe("9:41AM in California on June 13th 2016") {
            it("should be @736 .beats") {
                let region = Region(timeZoneName: TimeZoneName.AmericaLosAngeles)
                let currentDate = DateInRegion(year: 2016, month: 6,
                                               day: 13, hour: 9, minute: 41,
                                               region: region).absoluteTime

                expect(Int(currentDate.beats)).to(equal(736))
            }
        }

        describe("4:01PM in California on June 13th 2016") {
            it("should be @000 .beats") {
                let region = Region(timeZoneName: TimeZoneName.AmericaLosAngeles)
                let currentDate = DateInRegion(year: 2016, month: 6,
                                               day: 13, hour: 16, minute: 1,
                                               region: region).absoluteTime

                expect(Int(currentDate.beats)).to(equal(0))
            }
        }

        describe("4:02PM in California on June 13th 2016") {
            it("should be @000 .beats") {
                let region = Region(timeZoneName: TimeZoneName.AmericaLosAngeles)
                let currentDate = DateInRegion(year: 2016, month: 6,
                                               day: 13, hour: 16, minute: 2,
                                               region: region).absoluteTime

                expect(Int(currentDate.beats)).to(equal(1))
            }
        }

        describe("3:59PM in California on June 13th 2016") {
            it("should be @999 .beats") {
                let region = Region(timeZoneName: TimeZoneName.AmericaLosAngeles)
                let currentDate = DateInRegion(year: 2016, month: 6,
                                               day: 13, hour: 15, minute: 59,
                                               region: region).absoluteTime

                expect(Int(currentDate.beats)).to(equal(999))
            }
        }
    }
}
