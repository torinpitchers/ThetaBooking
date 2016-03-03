//  APICall.swift
//  ThetaBooking
//
//  Created by Harry Moy on 26/01/2016.
//  Edited by Toring itchers on 02/03/2016
//  Copyright © 2016 Genesis. All rights reserved.
//

import Foundation

enum APIError: ErrorType {
    case ResponseError
    case DictionaryError
}

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
    
    class func authenticate(username: String, password:String) throws {
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
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                guard error == nil && data != nil else {
                    return
                }
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                print(json)
                guard let tokenFromAPI = json["token"] as? String else {
                    throw APIError.ResponseError
                }
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(tokenFromAPI, forKey: "token")
            } catch {
                print("Error")
            }
        }).resume()
    }
    
    // <---------- User focused functions ----------->
    
    class func ResisterPerson(name: String, email: String, username: String, password: String, skills: [String], lecturer: Bool) throws {
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
        session.dataTaskWithRequest(request, completionHandler:{(data, response, error) -> Void in
            do {
                guard error == nil && data != nil else {
                    return
                }
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {
                    print("statusCode should be 201, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                let responseJson = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                print(responseJson)
            } catch {
                print("Error")
            }
        }).resume()
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
    
    class func deleteUser(email: String) throws {
        guard let emailString:String = email as String else {
            throw APIError.DictionaryError
        }
        let request = NSMutableURLRequest(URL: NSURL(string: "http://cortexapi.ddns.net:8080/api/deletePerson/\(emailString)")!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "DELETE"
        let session:NSURLSession = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                guard let _ = data else {
                    throw APIError.ResponseError
                }
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                print(json)
            } catch {
                print("Error")
            }
        }).resume()
    }
    
    class func modifyUser(email:String) throws {
        guard let emailString:String = email as String else {
            throw APIError.DictionaryError
        }
        let request = NSMutableURLRequest(URL: NSURL(string: "http://cortexapi.ddns.net:8080/api/modifyPerson/\(emailString)")!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "PUT"
        let session:NSURLSession = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            do {
                guard let _ = data else {
                    throw APIError.ResponseError
                }
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                print(json)
            } catch {
                print("Error")
            }
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
    
    class func createAppointment(start:String, end:String, date:String, participants:[String], bookable: String, location: String, reoccurance: String, title:String, notes: String) throws {
        
        guard let startString:String = start as String else {
            throw APIError.DictionaryError
        }
        guard let endString:String = end as String else {
            throw APIError.DictionaryError
        }
        guard let dateString:String = date as String else {
            throw APIError.DictionaryError
        }
        guard let participantsList:[String] = participants as [String] else {
            throw APIError.DictionaryError
        }
        guard let bookableString:String = bookable as String else {
            throw APIError.DictionaryError
        }
        guard let locationString:String = location as String else {
            throw APIError.DictionaryError
        }
        guard let reoccuranceString:String = reoccurance as String else{
            throw APIError.DictionaryError
        }
        guard let titleString:String = title as String else {
            throw APIError.DictionaryError
        }
        guard let notesString:String = notes as String else {
            throw APIError.DictionaryError
        }
        let dictionary:NSDictionary = [
            "startTime": startString,
            "endTime": endString,
            "date": dateString,
            "participants": participantsList,
            "bookable": bookableString,
            "location": locationString,
            "reoccurance": reoccuranceString,
            "title": titleString,
            "notes": notesString,
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
                    return
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