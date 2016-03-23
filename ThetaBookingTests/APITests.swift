//
//  APITests.swift
//  ThetaBooking
//
//  Created by Torin Pitchers on 23/03/2016.
//  Copyright © 2016 Genesis. All rights reserved.
//

import XCTest
@testable import ThetaBooking

class APITests: XCTestCase {

    override func setUp() {
        super.setUp()
        //testRegisterGood
        do{
            //try authenticate with known bad login
            let register = try APICall.ResisterPerson("dummy data", email: "dummy@data.com", username: "dummydata123", password: "123456789", skills: [], lecturer: false)
            //should be bad so will return false
            XCTAssertEqual(register, "success")
            
        }
        catch{
            XCTFail("should not be an error")
        }
    }
    
    override func tearDown() {
       // test deleteusergood
        do{
            //authenticate user to save token
            let auth = try APICall.authenticate("dummydata123", password: "123456789")
            //try delete user
            let del:Bool = try APICall.deleteUser("dummy@data.com")
            //should not be any errors so should get here
            
            
        }
        catch{
            XCTFail("should not be an error")
        }
        
        super.tearDown()
    }
    

    func testAuthenticationGood() {
        do{
            //try authenticate with known good login
            let auth = try APICall.authenticate("dummydata123", password: "123456789")
            //should be good so will return true
            XCTAssertEqual(auth, true)
            
        }
        catch{
        XCTFail("should not be an error")
        }
    
    }

    
    func testAuthenticationBad() {
        do{
            //try authenticate with known bad login
            let auth = try APICall.authenticate("torinpitchersrtrhyrtyrtytryrt", password: "12rtyrt34")
            //should be bad so will return false
            XCTAssertEqual(auth, false)
            
        }
        catch{
            XCTFail("should not be an error")
        }
        
    }
    
    
    func testAuthenticationUnexpectedInput() {
        do{
            //try authenticate with known bad login
            let auth = try APICall.authenticate("torin /?'$$%+_|!12'", password: "12rtyrt34 *&|}{>?<~!@#'")
            //should be bad so will return false
            XCTAssertEqual(auth, false)
            
        }
        catch{
            XCTFail("should not be an error")
        }
        
    }
    
   
    
    func testDeleteUserBad() {
        do{
            //authenticate user to save token
            let auth = try APICall.authenticate("dummydata123", password: "123456789")
            //try delete user with incorrect email
            let del:Bool = try APICall.deleteUser("dummy77@data.com")
            //should not be false as should fail
            XCTAssertEqual(del, false)
            
        }
        catch{
            XCTFail("should not be an error")
        }
        
    }
    
    func testModifyUserGood() {
        do{
            //authenticate user to save token
            let _ = try APICall.authenticate("dummydata123", password: "123456789")
            
            
            //construct user
            let aUser:User = User(name: "dummy data", email: "dummy@data.com", staff: false, skills: [], bio: "", picture: NSData())
            
            
            //try change password
            try APICall.modifyUser("dummy@data.com", updatedUser: aUser, password: "123")
            sleep(1)
            
            //try authenticate with new password
            let auth = try APICall.authenticate("dummydata123", password: "123")
            
            
            //should be true to pass
            XCTAssertEqual(auth, true)
            
            //try delete user
            let del:Bool = try APICall.deleteUser("dummy@data.com")
            
        }
        catch{
            XCTFail("should not be an error")
        }
        
    }




}
