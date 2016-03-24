//
//  FunctionTests.swift
//  ThetaBooking
//
//  Created by Torin Pitchers on 24/03/2016.
//  Copyright © 2016 Genesis. All rights reserved.
//

import XCTest
@testable import ThetaBooking

class FunctionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBoolExtTrue() {
        //define string of true
        let trueString = "true"
        //get bool value
        let boolValue = trueString.toBool()
        
        //should return true
        XCTAssertEqual(boolValue, true)
    }
    
    func testBoolExtTrueInt() {
        //define string of 1
        let trueString = "1"
        //get bool value
        let boolValue = trueString.toBool()
        
        //should return true
        XCTAssertEqual(boolValue, true)
    }
    
    func testBoolExtTrueCap() {
        //define string of True
        let trueString = "True"
        //get bool value
        let boolValue = trueString.toBool()
        
        //should return true
        XCTAssertEqual(boolValue, true)
    }
    
    func testBoolExtFalse() {
        //define string of false
        let trueString = "false"
        //get bool value
        let boolValue = trueString.toBool()
        
        //should return false
        XCTAssertEqual(boolValue, false)
    }
    
    func testBoolExtFalseInt() {
        //define string of 0
        let trueString = "0"
        //get bool value
        let boolValue = trueString.toBool()
        
        //should return true
        XCTAssertEqual(boolValue, false)
    }
    
    func testBoolExtFalseCap() {
        //define string of False
        let trueString = "False"
        //get bool value
        let boolValue = trueString.toBool()
        
        //should return true
        XCTAssertEqual(boolValue, false)
    }
    
    func testBoolExtBadInput() {
        //define string of hello
        let trueString = "hello"
        //get bool value
        let boolValue = trueString.toBool()
        
        //should return nil
        XCTAssertEqual(boolValue, nil)
    }
    
    func testDateExtValid() {
        
        //construct valid date from known timestamp
        let date:NSDate = NSDate(timeIntervalSince1970: 1458834497)
        //get string
        let string = date.makeStringFromDate(date)
        //test output with expected output
        XCTAssertEqual(string, "Thursday, March 24, 2016 at 3:48:17 PM")
        
    }


        
}
