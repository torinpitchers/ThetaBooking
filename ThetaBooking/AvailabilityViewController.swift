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
    
    var startDate: String = ""
    var startTime: String = ""
    var endTime: String   = ""
    var people: [String]  = []
    var bookable: Bool = false
    var recurrence: Bool = false
    let retrieveUsername: String = NSUserDefaults.standardUserDefaults().objectForKey("username") as! String

    
    
    @IBOutlet weak var LecturerName: UILabel!
 
    @IBOutlet weak var AvailableFromPicker: ColoredDatePicker!
    
    @IBOutlet weak var AvailableToPicker: ColoredDatePicker!
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var Notes: UITextView!
    
    
    @IBAction func submitButton(sender: AnyObject) {
        
        if (startTime == "" || endTime == "" || startDate == "") {
            let alertView = UIAlertController(title: "Check Day and Time!",
                message: "Please ensure that you've selected a day and time!" as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            return;
        }
//        if startTime <= endTime{
//            let alertView = UIAlertController(title: "Please check the time!",
//                message: "Please ensure that you've selected a day and time!" as String, preferredStyle:.Alert)
//            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//            alertView.addAction(okAction)
//            self.presentViewController(alertView, animated: true, completion: nil)
//            return;

//        }
        do {
        try APICall.createAppointment(startTime, end: endTime, date: startDate, participants: people, bookable: bookable, location: "Theta", reoccurance: recurrence, title: retrieveUsername, notes: Notes.text)
        } catch {
            print("Error making create appointment")
        }

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AvailableFromPicker.addTarget(self, action: Selector("AvailableFromChanged:"), forControlEvents: UIControlEvents.AllEvents)
        
        AvailableToPicker.addTarget(self, action: Selector("AvailableToChanged:"), forControlEvents: UIControlEvents.AllEvents)

     
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("forceDates"), userInfo: nil, repeats: true)
        

        
    }
    
    
    
    func AvailableFromChanged(datePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        let timeFormatter = NSDateFormatter()
        //to set the time in 24hr
        timeFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        timeFormatter.dateFormat = "HH:mm"
        
        //to set the day in number style
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        //set the variables to equal the output string
        startDate = dateFormatter.stringFromDate(datePicker.date)
        startTime = timeFormatter.stringFromDate(datePicker.date)
        
    }
    
    func AvailableToChanged(datePicker:UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        //to get the end time
        timeFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        timeFormatter.dateFormat = "HH:mm"
        
        endTime = timeFormatter.stringFromDate(datePicker.date)
        
    }
    
    func forceDates(){
        let currentDate = NSDate()
        AvailableFromPicker.minimumDate = currentDate
        let laterDate = AvailableFromPicker.date
        AvailableToPicker.minimumDate = laterDate
        
        
    }
    
    func checkText(){
        if textField.text != ""{
            people.append(textField.text!)
            print(people)
        } else{
            if (startTime == "" || endTime == "" || startDate == "") {
                let alertView = UIAlertController(title: "Check Atendees!",
                    message: "Please ensure that you've input atendees" as String, preferredStyle:.Alert)
                let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertView.addAction(okAction)
                self.presentViewController(alertView, animated: true, completion: nil)
                return;
            }

        }
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