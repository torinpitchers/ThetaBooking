//
//  myprofile.swift
//  ThetaBooking
//
//  Created by Matthew Dee on 17/03/2016.
//  Copyright © 2016 Genesis. All rights reserved.
//
import UIKit

class myprofile: UIViewController {
    
    func goTo(sender: UIBarButtonItem) {
        
        performSegueWithIdentifier("ProfileToEdit", sender: self)
        
        
    }
    
    override func viewDidLoad() {
        let barbutton: UIBarButtonItem = UIBarButtonItem(title: "Edit Profile", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("goTo:"))
        
        self.navigationItem.rightBarButtonItem = barbutton
        super.viewDidLoad()
        
    
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationItem.rightBarButtonItem?.enabled = true
    }
    

    
}
