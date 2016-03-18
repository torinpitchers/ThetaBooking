//
//  AvailabilityViewController.swift
//  ThetaBooking
//
//  Created by Matthew Copson on 18/03/2016.
//  Copyright © 2016 Genesis. All rights reserved.
//

import Foundation
import UIKit

class AvailabilityViewController: UIViewController{
    var startDate = ""
    var startTime = ""
    var endDate = ""
    var endTime = ""
    
    @IBOutlet weak var LecturerName: UILabel!
 
    @IBOutlet weak var AvailableFromPicker: ColoredDatePicker!
    
    @IBOutlet weak var AvailableToPicker: ColoredDatePicker!
    
    
    @IBAction func submitButton(sender: AnyObject) {
        print(startTime)
        print(startDate)
        print(endTime)
        print(endDate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AvailableFromPicker.addTarget(self, action: Selector("AvailableFromChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        AvailableToPicker.addTarget(self, action: Selector("AvailableToChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
     
        NSTimer.scheduledTimerWithTimeInterval(1.1, target: self, selector: Selector("forceDates"), userInfo: nil, repeats: true)
        

        
    }
    
    func AvailableFromChanged(datePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        let timeFormatter = NSDateFormatter()
        
        timeFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        timeFormatter.dateFormat = "HH:mm"
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        let strTime = timeFormatter.stringFromDate(datePicker.date)
        startDate = strDate
        startDate = strTime
       
    }
    
    func AvailableToChanged(datePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        let timeFormatter = NSDateFormatter()
        
        timeFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        timeFormatter.dateFormat = "HH:mm"
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        let strTime = timeFormatter.stringFromDate(datePicker.date)
        endDate = strDate
        endTime = strTime
        
    }
    
    func forceDates(){
        let currentDate = NSDate()
        
        AvailableFromPicker.minimumDate = currentDate
        let laterDate = AvailableFromPicker.date
        AvailableToPicker.minimumDate = laterDate
        // couldnt find a way to add 7 days
        AvailableToPicker.maximumDate = laterDate
        
    }


    
}

class ColoredDatePicker: UIDatePicker {
    var changed = false
    override func addSubview(view: UIView) {
        if !changed {
            changed = true
            self.setValue(UIColor.whiteColor(), forKey: "textColor")
        }
        super.addSubview(view)
    }
}