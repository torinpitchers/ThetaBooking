//
//  editProfile.swift
//  ThetaBooking
//
//  Created by Matthew Dee on 17/03/2016.
//  Copyright © 2016 Genesis. All rights reserved.
//

import UIKit

class editProfile: UIViewController {
    
    @IBAction func saveProfileChanges(sender: AnyObject) {
        
        performSegueWithIdentifier("ChangesToProfile", sender: nil)
        
        }
    
override func viewDidLoad() {
    self.navigationItem.rightBarButtonItem?.enabled = false
    
    }
}