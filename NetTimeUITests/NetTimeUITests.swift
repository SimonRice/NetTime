//
//  NetTimeUITests.swift
//  NetTimeUITests
//
//  Created by Simon Rice on 22/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import Nimble
import SimulatorStatusMagiciOS
import XCTest

class NetTimeUITests: XCTestCase {
    override func setUp() {
        super.setUp()

        self.continueAfterFailure = false
        SDStatusBarManager.sharedInstance().enableOverrides()

        let app = XCUIApplication()
        setupSnapshot(app)
        app.launchArguments = ["TEST_MODE"]
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
        SDStatusBarManager.sharedInstance().disableOverrides()
    }

    func testValues() {
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Now"].tap()

        expect(app.staticTexts["@403.47"]).toNot(beNil())
        tabBarsQuery.buttons["Calculate"].tap()

        let tablesQuery = app.tables
        expect(app.staticTexts["@422 .beats"].exists).to(beTrue())
        expect(tablesQuery.staticTexts["1/1/16, 10:09 AM"].exists).to(beTrue())

        tablesQuery.staticTexts["1/1/16, 10:09 AM"].tap()
        tablesQuery.pickerWheels["10 o'clock"].adjustToPickerWheelValue("9")
        tablesQuery.pickerWheels["09 minutes"].adjustToPickerWheelValue("41")

        expect(app.staticTexts["@403 .beats"].exists).to(beTrue())
    }


    func testTakeSnapshots() {
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Now"].tap()
        snapshot("01_Now")

        tabBarsQuery.buttons["Calculate"].tap()

        let tablesQuery = app.tables
        tablesQuery.staticTexts["Europe/Zurich"].tap()
        tablesQuery.pickerWheels["Europe/Zurich"].adjustToPickerWheelValue("Europe/London")

        tablesQuery.staticTexts["1/1/16, 10:09 AM"].tap()
        tablesQuery.pickerWheels["10 o'clock"].adjustToPickerWheelValue("9")
        tablesQuery.pickerWheels["09 minutes"].adjustToPickerWheelValue("41")
        tablesQuery.staticTexts["1/1/16, 9:41 AM"].tap()

        snapshot("02_Calculate")
    }
}
