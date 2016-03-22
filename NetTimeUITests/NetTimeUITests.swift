//
//  NetTimeUITests.swift
//  NetTimeUITests
//
//  Created by Simon Rice on 22/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import XCTest

class NetTimeUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()

        let app = XCUIApplication()
        continueAfterFailure = false
        setupSnapshot(app)
        app.launch()

        
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
