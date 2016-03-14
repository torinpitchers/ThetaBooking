//
//  Staff.swift
//  ThetaBooking
//
//  Created by Matthew Copson on 25/01/2016.
//  Copyright © 2016 Harry Moy. All rights reserved.
//

import Foundation
import UIKit

enum UserError:ErrorType {
    case IndexNotValid
}

struct User {
    var name: String //Searchable
    var email: String //Primary Key
    var staff: Bool
    var skills: [String]
    var bio: String
    var picture: NSData
}

class Users {
    
    private var UserList:[User]
    var searchResults:[User]
    
    // static class public property that returns a Budget object
    static let getInstance = Users()
    
    init() {
        UserList = []
        searchResults = []
    }
    
    

    
    func count() -> Int {
        return self.UserList.count
    }
    
    func getUser(Index:Int) throws -> User {
        if 0 > Index || Index > self.UserList.count - 1 {
            throw UserError.IndexNotValid
        }
        
        return UserList[Index]
    }
    
    func getList() -> [User] {
        return UserList
    }
    
    
    func search(text:String) {
       
        searchResults = [] //empty the search results container
        let searchRange = Range(start: text.startIndex, end: text.endIndex) //calulate range of search
        
        for person in Users.getInstance.getList() {
            if searchRange.count > person.name.characters.count {
                continue
            }
            let substring = person.name.substringWithRange(searchRange) //get substring from range
            if substring.lowercaseString == text.lowercaseString {
                searchResults.append(person)
                
            }
        }
        print(searchResults.count)
    }
    
    func clear() -> Void {
        self.searchResults = []
        self.UserList = []
    }

    
    
    
}