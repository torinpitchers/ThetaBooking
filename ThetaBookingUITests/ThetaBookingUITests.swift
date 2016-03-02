//
//  ThetaBookingUITests.swift
//  ThetaBookingUITests
//
//  Created by Harry Moy on 18/01/2016.
//  Copyright © 2016 Harry Moy. All rights reserved.
//

import XCTest

class ThetaBookingUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNavigation() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        app.buttons["Create an account"].tap()
        app.buttons["Cancel"].tap()
        app.buttons["Login"].tap()
        app.navigationBars["Student Homepage"].buttons["settings"].tap()
        app.navigationBars["Settings"].buttons["Student Homepage"].tap()
        
        let tablesQuery2 = app.tables
        let tablesQuery = tablesQuery2
        tablesQuery.staticTexts["Search"].tap()
        tablesQuery.staticTexts["Games, C++, AGILE, Web Technologies, Design."].tap()
        // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
        
        let markTyersOrSwiftIosSearchField = tablesQuery2.searchFields["\"Mark Tyers\" or \"Swift, iOS...\""]
        markTyersOrSwiftIosSearchField.tap()
        markTyersOrSwiftIosSearchField.typeText("ma")
        
    }
    
    func testSearch() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        app.buttons["Login"].tap()
        
        let tablesQuery2 = app.tables
        let tablesQuery = tablesQuery2
        tablesQuery.staticTexts["Search"].tap()
        tablesQuery.staticTexts["Games, C++, AGILE, Web Technologies, Design."].tap()
        // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
        
        let markTyersOrSwiftIosSearchField = tablesQuery2.searchFields["\"Mark Tyers\" or \"Swift, iOS...\""]
        markTyersOrSwiftIosSearchField.tap()
        markTyersOrSwiftIosSearchField.typeText("ma")
        
        tablesQuery.staticTexts["Mark Tyers"].exists
        XCTAssertEqual(tablesQuery.staticTexts["Mark Tyers"].exists, true)
        
        
        
        
        
        
    }

    
}
