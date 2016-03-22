//
//  BookingsViewController.swift
//  ThetaBooking
//
//  Created by Matthew Copson on 17/03/2016.
//  Copyright © 2016 Genesis. All rights reserved.
//

import Foundation
import UIKit

class BookingsViewController: UITableViewController {
    
    struct BookingsObject{
        var sectionName :  String
        var sectionObject : [(startTime: String, endTime: String , People: [String], Note: String,Location: String, fullDate: String)]
    }
    

    
    
    var objectArray = [BookingsObject]()
    
    var selectedIndexPath: NSIndexPath? = nil
    
    override func viewDidLoad() {
        let today = NSDate()
        let date = NSDate().makeStringForDate(today)
        objectArray = [
            BookingsObject(sectionName: date , sectionObject:[("10:00","10:15",["Mark Tyres", "Matthew Copson"],"I need help with swift!", "ECG1",date)]),
            BookingsObject(sectionName: date , sectionObject:[("10:15","10:30",["Mark Tyres", "Harry Moy"],"Save Me a table ;)", "ECG1",date)]),
            BookingsObject(sectionName: date , sectionObject:[("10:30","10:45",["Mark Tyres", "Torin Pitchers","Matthew Dee"],"My nicknames womble.", "ECG1",date)])
        
    ]
        
          }

    

    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return 1
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObject.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookingCustomCell", forIndexPath: indexPath) as! BookingCustomCell
                if let label = cell.startTime{
                    label.text = objectArray[indexPath.section].sectionObject[indexPath.row].startTime
            }
      if let label = cell.endTime {
            label.text = objectArray[indexPath.section].sectionObject[indexPath.row].endTime
        }
        if let label = cell.Attendees{
            let newArray = objectArray[indexPath.section].sectionObject[indexPath.row].People
            var attendees = ""
            for i in newArray{
                attendees += i+" "
            }
            label.text = attendees
            
        }
        if let label = cell.Location{
            
            label.text = objectArray[indexPath.section].sectionObject[indexPath.row].Location
            label.hidden = true
            
        }
        if let label = cell.fullDate{
            label.text = objectArray[indexPath.section].sectionObject[indexPath.row].fullDate
            label.hidden = true
        }
        if let label = cell.notesLabel{
            label.text = objectArray[indexPath.section].sectionObject[indexPath.row].Note
            label.hidden = true
        }


        return cell
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
    
    let deleteAction = UITableViewRowAction(style: .Default, title: "Cancel Appointment") {action in
        self.objectArray.removeAtIndex(indexPath.row)
        tableView.reloadData()
        
        
        }
        let editAction = UITableViewRowAction(style: .Normal, title: "Edit") {action in
            print("edited")
        }
        
        return [deleteAction, editAction]
    }

    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return objectArray.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return objectArray[section].sectionName
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookingCustomCell") as! BookingCustomCell
        
      
        switch selectedIndexPath {
        case nil:
            selectedIndexPath = indexPath
            print("opened")
            if let label = cell.Location{
                
                label.text = objectArray[indexPath.section].sectionObject[indexPath.row].Location
                label.hidden = false
                print(label.text)

            }
            if let label = cell.fullDate{
                label.text = objectArray[indexPath.section].sectionObject[indexPath.row].fullDate
                label.hidden = false
                print(label.text)
            }
            if let label = cell.notesLabel{
                label.text = objectArray[indexPath.section].sectionObject[indexPath.row].Note
                label.hidden = false
                cell.notesLabel.text = objectArray[indexPath.section].sectionObject[indexPath.row].Note
                cell.notesLabel.hidden = false
                print(label.text)
            }

        default:
            if selectedIndexPath! == indexPath {
                selectedIndexPath = nil
               
                if let label = cell.startTime{
                    label.text = ""
                    label.hidden = true
                }
                if let label = cell.fullDate{
                     label.text = ""
                     label.hidden = true
                }
                if let label = cell.notesLabel{
                     label.text = ""
                     label.hidden = true
                }

              
            } else {
                selectedIndexPath = indexPath
            }
        }
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let smallHeight: CGFloat = 65.0
        let expandedHeight: CGFloat = 200.0
        let ip = indexPath
        if selectedIndexPath != nil {
            if ip == selectedIndexPath! {
                
                return expandedHeight
            } else {
                return smallHeight
            }
        } else {
            return smallHeight
        }
    }
}

class BookingCustomCell: UITableViewCell {
    
    
    @IBOutlet weak var startTime: UILabel!
    
    @IBOutlet weak var endTime: UILabel!
    
    @IBOutlet weak var Attendees: UILabel!
    
    @IBOutlet weak var Location: UILabel!
    
    @IBOutlet weak var fullDate: UILabel!
    
    @IBOutlet weak var notesLabel: UILabel!
    

    
}