//
//  ThetaBookingTests.swift
//  ThetaBookingTests
//
//  Created by Matt Dee & Torin pitchers on 18/01/2016.
//  Copyright © 2016 Genesis. All rights reserved.
//

import XCTest
@testable import ThetaBooking

class ThetaBookingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        //load users to the userlist and SearchResults
       Users.getInstance.load()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        //clear UserList and SearchResults
        Users.getInstance.clear()
    }
    
    func testSearchSuccessful() {
        //perform search on userList for 'mark'
        Users.getInstance.search("mark")
        // check if search results count is not empty
        XCTAssertGreaterThan(Users.getInstance.searchResults.count, 0)
        //retrieve the first search result
        let user = Users.getInstance.searchResults[0]
        //check that the search term is present in the search result
        XCTAssertEqual(user.name.lowercaseString.containsString("mark"), true)
        
        
        
    }
    
    func testSearchUnsucessful() {
        //perform search on userList that is known to not match any persons
        Users.getInstance.search("hgjfkskkddffhg")
        //check that results is empty
        XCTAssertEqual(Users.getInstance.searchResults.count, 0)

        
    }
    
    
    func testSearchEmpty() {
        //perform empty search
        Users.getInstance.search("")
        //check that results contains every user from the userlist
        XCTAssertEqual(Users.getInstance.searchResults.count, Users.getInstance.count())
        
        
    }
    
    func testGetUserGoodIndex() {
        //do block
        do {
            //if there are users to retrieve
            if Users.getInstance.getList().count != 0 {
                //try retrieve the first user
                _ = try Users.getInstance.getUser(0)
                //success if reach this line
                XCTAssertTrue(true)
            }
        }
        catch {
            //fail if error is found
            XCTFail("Error should not be found on a good index.")
        }
        
    }
    
    func testGetUserBadIndex() {
        //do block
        do {
            //try retrieve a user that is known to not exist
            _ = try Users.getInstance.getUser(190000)
            //Fail if reach this line
            XCTFail("Should not reach this line")
            }
            
        catch UserError.IndexNotValid{
            //pass if correct error is found
            XCTAssertTrue(true)
        }
        catch {
            //Fail if error is not correct
            XCTFail("Error different than expected")
        }
    }

    
}
