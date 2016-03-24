//  APICall.swift
//  ThetaBooking
//
//  Created by Harry Moy on 26/01/2016.
//  Edited by Toring itchers on 02/03/2016
//  Copyright © 2016 Genesis. All rights reserved.
//

import Foundation
import UIKit

enum APIError: ErrorType {
    case ResponseError
    case DictionaryError
    case DefaultsError
}

let defaults = NSUserDefaults.standardUserDefaults()

protocol APICallProtocol {
    func getThetaCalendar() throws
    func getStaffDetails() throws
    func getStudentDetails() throws
    func getAppointments() throws
    func getBookings() throws
    func postAppointment() throws
    func postAvailability() throws
    func postAttendance() throws
    func postSkills() throws
}

class APICall {
    class func getThetaCalendar(completion: ([User]) -> ()) throws {
        let userList = [User]()
        let url:NSURL = NSURL(string:"http://cortexapi.ddns.net:8080/api/theta")!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "GET"
        let session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                print(response)
                guard let _ = data else {
                    throw APIError.ResponseError
                }
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                print(json)
                
            } catch {
                print("Error: \(error)")
                print("Response is: \(response)")
            }
            completion(userList)
        }).resume()
    }
    
    class func getThetaCalendarByDay(day: String, completion: ([Booking]) -> ()) throws {
        let bookingList = [Booking]()
        let url: NSURL = NSURL(string: "http://cortextapi.ddns.net:8080/api/thetaDay/\(day)")!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "GET"
        let session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                guard let _ = data else {
                    throw APIError.ResponseError
                }
                let json = try NSJSONSerialization.dataWithJSONObject(data!, options: [])
                print(json)
            } catch {
                print("Error")
            }
            completion(bookingList)
        }).resume()
    }
    
    class func getAllSkills(completion: ([String]) -> ()) throws {
        var skillsList = [String]()
        let url:NSURL = NSURL(string:"http://cortexapi.ddns.net:8080/api/getAllSkills")!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "GET"
        let session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                //print(response)
                guard let _ = data else {
                    throw APIError.ResponseError
                }
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                print(json)
                let data: AnyObject = json["data"] as AnyObject!
                
                for (var i:Int = 0; i<data.count; i++) {
                    let name:String = data[i]["name"] as! String
                    skillsList.append(name)
                }
                
            } catch {
                print("Error: \(error)")
                print("Response is: \(response)")
            }
            completion(skillsList)
        }).resume()
    }
    
    class func getUser(skill:String, completion: ([User]) -> ()) throws {
        var userResults:[User] = [User]()
        let url:NSURL = NSURL(string:"http://cortexapi.ddns.net:8080/api/getPersonBySkill/\(skill)")!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "GET"
        let session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                //print(response)
                guard let _ = data else {
                    throw APIError.ResponseError
                }
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                print(json)
                let data: AnyObject = json["data"] as AnyObject!
                
                for (var i:Int = 0; i<data.count; i++) {
                    
                    let name:String = data[i]["name"] as! String
                    let email:String = data[i]["email"] as! String
                    
                    userResults.append(User(name: name, email: email, staff: true, skills: [], bio: "", picture: NSData()))
                }

            } catch {
                print("Error: \(error)")
                print("Response is: \(response)")
            }
            completion(userResults)
        }).resume()
    }
    
    class func getUserByEmail(email:String, completion: (User) -> ()) throws {
        var user:User!
        let url:NSURL = NSURL(string:"http://cortexapi.ddns.net:8080/api/lookUpPerson/\(email)")!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "GET"
        let session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                //print(response)
                guard let _ = data else {
                    throw APIError.ResponseError
                }
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                print(json)
                let data: AnyObject = json["data"] as AnyObject!
                
               
                    
                    let name:String = data[0] as! String
                    let email:String = data[1] as! String
                    let skills:[String] = data[2] as! [String]
                    
                    user = User(name: name, email: email, staff: true, skills: skills, bio: "", picture: NSData())
                
                
            } catch {
                print("Error: \(error)")
                print("Response is: \(response)")
            }
            completion(user)
        }).resume()
    }


    
    class func authenticate(username: String, password:String) throws -> Bool{
        guard let userString: String = username as String else {
            throw APIError.DictionaryError
        }
        guard let passString: String = password as String else {
            throw APIError.DictionaryError
        }
        
        let loginString = NSString(format:"%@:%@", userString, passString)
        let loginData:NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64String = loginData.base64EncodedStringWithOptions([])
        let request = NSMutableURLRequest(URL: NSURL(string:"http://cortexapi.ddns.net:8080/api/authenticate")!)
        request.HTTPMethod = "POST"
        //request.setValue(base64String, forKey: "Authorization")
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session:NSURLSession = NSURLSession.sharedSession()
        var success: Bool!
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                guard error == nil && data != nil else {
                    return
                }
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 && httpStatus.statusCode != 201  {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    success = false
                }
                else {
                    success = true
                }
                
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                print(json)
                guard let tokenFromAPI = json["data"] as? String else {
                    throw APIError.ResponseError
                }
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(tokenFromAPI, forKey: "token")
            } catch {
                print("Error")
            }
        }).resume()
        sleep(1)
        return success
    }
    
    // <---------- User focused functions ----------->
    
    class func ResisterPerson(name: String, email: String, username: String, password: String, skills: [String], lecturer: Bool) throws -> String {
        let dictionary: NSDictionary = [
            "name": name,
            "email": email,
            "username": username,
            "password": password,
            "skills": skills,
            "lecturer": lecturer
        ]
        let json = try NSJSONSerialization.dataWithJSONObject(dictionary, options:[])
        let request = NSMutableURLRequest(URL: NSURL(string:"http://cortexapi.ddns.net:8080/api/addNewPerson")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = json
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session:NSURLSession = NSURLSession.sharedSession()
        var success: Bool!
        var message: String?
        session.dataTaskWithRequest(request, completionHandler:{(data, response, error) -> Void in
            do {
                guard error == nil && data != nil else {
                    success = false
                    message = "Failed - Unkown Error "
                    return
                    
                }
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {
                    print("statusCode should be 201, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    success = false
                    message = "Failed - http response not good "
                    
                    if httpStatus.statusCode == 401 {
                        success = false
                        message = "Failed - Username taken, please choose another "
                    }
                    
                }
                else {
                    success = true
                    message = "success"
                }
                
                let responseJson = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                
                
                print(responseJson)
                
            } catch {
                print("Error")
            }
        }).resume()
        sleep(1)
        if success == true {
            return "success"
        }
        else {
            return message!
        }
        
    }
    
    
    class func postPerson(name: String, email: String, username: String, password: String, skills: [String], lecturer: Bool) throws {
        let dictionary: NSDictionary = [
            "name": name,
            "email": email,
            "username": username,
            "password": password,
            "skills": skills,
            "lecturer": lecturer
        ]
        let json = try NSJSONSerialization.dataWithJSONObject(dictionary, options:[])
        let request = NSMutableURLRequest(URL: NSURL(string:"http://cortexapi.ddns.net:8080/api/addNewLecturer")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = json
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session:NSURLSession = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler:{(data, response, error) -> Void in
            do {
                guard error == nil && data != nil else {
                    return
                }
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                let responseJson = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                print(responseJson)
            } catch {
                print("Error")
            }
        }).resume()
    }
    
    class func deleteUser(email: String) throws -> Bool {
        guard let emailString:String = email as String else {
            throw APIError.DictionaryError
        }
        let request = NSMutableURLRequest(URL: NSURL(string: "http://cortexapi.ddns.net:8080/api/deletePerson/\(emailString)")!)
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "DELETE"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let token = defaults.valueForKey("token") as! String
        var success = false

        request.setValue(token, forHTTPHeaderField: "token")
        let session:NSURLSession = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                guard let _ = data else {
                    throw APIError.ResponseError
                }
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                print(json)
                
                if json["status"] as! String == "success" {
                    success = true
                }
            } catch {
                print("Error")
            }
        }).resume()
        sleep(1)
        return success
    }
    
    class func modifyUser(email:String, updatedUser:User, password:String) throws {
        guard let emailString:String = email as String else {
            throw APIError.DictionaryError
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        let token = defaults.valueForKey("token") as! String
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://cortexapi.ddns.net:8080/api/modifyPerson/\(emailString)")!)
        
        request.setValue(token, forHTTPHeaderField: "token")
        
        let userData: NSDictionary = [
            "name": updatedUser.name,
            "email": updatedUser.email,
            "password": password,
            "lecturer": false
        ]
        
        let json = try NSJSONSerialization.dataWithJSONObject(userData, options:[])
        
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "PUT"
        request.HTTPBody = json
        let session:NSURLSession = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                guard let _ = data else {
                    throw APIError.ResponseError
                }
                let responsejson = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                print(responsejson)
                
                
                
                
                
                
            } catch {
                print("Error")
            }
        }).resume()
    }
    
    class func getAllLocations() throws {
        _ = [String]()
        let urlString = "http://cortexapi.ddns.net:8080/api/getAllLocations"
        let url: NSURL = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "GET"
        let session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                guard let _ = data else {
                    throw APIError.ResponseError
                }
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                print(json)
                let _: AnyObject = json["data"] as AnyObject!
                
            } catch {
                print("Error getting locations")
            }
        })
    }
    
    class func postAvailability(avail: Availability) throws {
        guard let token = defaults.objectForKey("token") as? String else {
            throw APIError.DefaultsError
        }
        let dictionary: NSDictionary = [
            "name": avail.name,
            "timeStart": avail.start,
            "timeStop": avail.end,
            "date":avail.end,
            "notes":avail.notes,
            "recurringWeekly": avail.reucurring,
            "bookable": avail.bookable,
            "username": avail.username
        ]
        let json = try NSJSONSerialization.dataWithJSONObject(dictionary, options:[])
        let urlString = "http://cortexapi.ddns.net:8080/api/addNewAvailability"
        let url:NSURL = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPBody = json
        request.HTTPMethod = "POST"
        request.addValue(token, forHTTPHeaderField: "token")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                guard error == nil && data != nil else {
                    return
                }
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                let responseJson = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                print(responseJson)
            } catch {
                print("Error")
            }
        }).resume()
    }
    
    
    class func AllLecturers(completion: ([User]) -> ()) throws {
        let url:NSURL = NSURL(string: "http://cortexapi.ddns.net:8080/api/getAllLecturer")!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        var userlist:[User] = []
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session:NSURLSession = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                guard error == nil && data != nil else {
                    return
                }
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                
                let dataobjects: AnyObject = json["data"] as AnyObject!
                
                
                for (var i:Int = 0; i<dataobjects.count; i++) {
                    let name:String = dataobjects[i][1] as! String
                    let email:String = dataobjects[i][2] as! String
                    let skills:[String] = dataobjects[i][0] as! [String]
                    
                    let user:User = User(name: name, email: email, staff: true, skills: skills, bio: "", picture: NSData())
                    
                    userlist.append(user)
                }
                
                
                
            } catch {
                print("Error")
            }
            completion(userlist)
        }).resume()
    }

    
    
    
    class func searchForLecturer(email:String, completion: ([User]) -> ()) throws {
        guard let emailForRequest:String = email as String else {
            throw APIError.ResponseError
        }
        let url:NSURL = NSURL(string: "http://cortexapi.ddns.net:8080/api/lookUpLecturer/\(emailForRequest)")!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session:NSURLSession = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                guard error == nil && data != nil else {
                    return
                }
                _ = try NSJSONSerialization.dataWithJSONObject(data!, options: [])
                
                
            } catch {
                print("Error")
            }
            
        }).resume()
    }
    
    class func getUserByName(name: String, completion: ([User]) -> ()) throws {
        var userResults:[User] = [User]()
        guard let nameString:String = name else {
            throw APIError.DictionaryError
        }
        
        let url:NSURL = NSURL(string: "http//cortexapi/ddns.net:8080/api/getUserByName/\(nameString)")!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session:NSURLSession = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                let json = try  NSJSONSerialization.JSONObjectWithData(data!, options: [])
                let data: AnyObject = json["data"] as AnyObject!
                guard let nameFromResponse:String = data["name"] as? String else {
                    throw APIError.ResponseError
                }
                guard let email: String = data["email"] as? String else {
                    throw APIError.ResponseError
                }
                guard let username: String = data["username"] as? String else {
                    throw APIError.ResponseError
                }
                guard let skills: [String] = data["skills"] as? [String] else {
                    throw APIError.ResponseError
                }
                guard let lecturerString: String = data["lecturer"] as? String else {
                    throw APIError.ResponseError
                }
                let lecturer = lecturerString.toBool()
                let newUser = User(name: nameFromResponse, email: email, staff: lecturer!, skills: skills, bio: "", picture: NSData())
                userResults.append(newUser)
            } catch {
                print("Error")
            }
            completion(userResults)
        }).resume()
    }
    
    class func createAppointment(booking: Booking) throws {
        
        let dictionary:NSDictionary = [
            "startTime": booking.start,
            "endTime": booking.end,
            "date": booking.date,
            "participants": booking.participants,
            "bookable": booking.bookable,
            "location": booking.location,
            "reoccurance": true,
            "title": booking.title,
            "notes": booking.notes,
            "parentApp": "ThetaBooking-iOS"
        ]
        
        let json = try NSJSONSerialization.dataWithJSONObject(dictionary, options:[])
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "http://cortexapi.ddns.net:8080/api/addNewAppointment")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = json
        request.addValue("Content-Type", forHTTPHeaderField: "application/json")
        let session:NSURLSession = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                guard error == nil && data != nil else {
                    throw APIError.ResponseError
                }
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
            } catch {
                print("Error")
            }
        }).resume()
    }
    
}