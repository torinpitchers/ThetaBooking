//
//  Staff.swift
//  ThetaBooking
//
//  Created by Matthew Copson on 25/01/2016.
//  Copyright © 2016 Harry Moy. All rights reserved.
//

import Foundation
import UIKit

struct User {
    var name: String //Searchable
    var email: String //Primary Key
    var staff: Bool
    var skills: [String]
    var bio: String
    var picture: UIImage
}

class Users {
    
    private var UserList:[User]
    
    // static class public property that returns a Budget object
    static let getInstance = Users()
    
    init() {
        UserList = []
    }
    
    
    func load() -> Void {
        
        
        //populate list with dummy data
        
        
        var url = NSURL(string: "http://www.coventry.ac.uk/Global/06%20Life%20on%20Campus%20section%20assets/Faculty%20of%20Engineering%20and%20Computing/Department%20of%20Computing/Staff%20Profile%20Images/Mike_Tyers.jpeg")
        
        var data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        var image = UIImage(data: data!)
        
        let user1 = User(name: "Mark Tyers", email: "m.tyers@coventry.ac.uk", staff: true, skills: ["Swift", "iOS", "Cloud Computing", "AGILE"], bio: "Mark received his engineering degree in 1991. He currently holds the post of Senior Lecturer specialising in ‘Web Technologies’, a broad term that covers the key areas of Cloud Computing, Web API development and Smartphone Development focussing on the iOS and Android platforms.", picture: image!)
        
        url = NSURL(string: "http://www.coventry.ac.uk/PageFiles/66371/FB_20150317_11_30_54_Saved_Picture.jpg")
        data = NSData(contentsOfURL: url!)
        image = UIImage(data: data!)
        
        let user2 = User(name: "Reda Al Bodour", email: "Ab3505@coventry.ac.uk", staff: true, skills: ["Big Data", "Data Mining", "Networks", "Distributed Systems", "Cloud Computing"], bio: "Reda has been part of the Coventry University team since 2006 taking on multiple roles in both research and teaching. Currently a Lecturer in Computing, Reda has represented the University at conferences and workshops both within the UK and abroad. Reda received a PhD in Grid and Cloud Computing and is interested in Distributed Systems, Grid Computing and Computer Networks. Other interests in different fields include Journalism, Sports and Biomedical Engineering.", picture: image!)
        
        url = NSURL(string: "http://www.coventry.ac.uk/Global/06%20Life%20on%20Campus%20section%20assets/Faculty%20of%20Engineering%20and%20Computing/Department%20of%20Computing/Staff%20Profile%20Images/Dr-Craig-Stewart_New.png")
        data = NSData(contentsOfURL: url!)
        image = UIImage(data: data!)
        
        let user3 = User(name: "Craig Stewart", email: "craig.stewart@coventry.ac.uk", staff: true, skills: ["Games", "C++", "AGILE", "Web Technologies", "Design"], bio: "Dr Stewart has worked in the area of HCI, IT & multimedia research and education for over 20 years. He has a great deal of experience in many fields from working in various departments, disciplines and positions. His academic background reflects this diversity with a PhD in Computer Science from the University of Nottingham and an MSc in Molecular Genetics and a BSc in Genetics (from the universities of Leicester and Nottingham respectively). He is the Lecturer for the MSc in Digital Games and Business Innovation at the Serious Games Institute, Coventry University.", picture: image!)
        
        
        
        
        
        
        
        self.UserList.append(user1)
        self.UserList.append(user2)
        self.UserList.append(user3)
    }
    
    func count() -> Int {
        return self.UserList.count
    }
    
    func getUser(Index:Int) -> User {
        return UserList[Index]
    }
    
    func getList() -> [User] {
        return UserList
    }
    
    
    
}