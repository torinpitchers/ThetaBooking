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
    
    
    
    
    let items:[menuItem] = [item1,item2,item3]

    
    var selectedIndexPath: NSIndexPath? = nil
    
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookingCustomCell", forIndexPath: indexPath) as! BookingCustomCell
        
        if let label = cell.startTime{
            label.text = "hello"
        }
        if let label = cell.endTime {
            label.text = "goodbye"
        }
        if let label = cell.Attendees{
            label.text = "people..."
        }
        if let label = cell.hideMe{
            label.text = "this should be hidden"
        }
        

        //cell.contentView.alpha = 0.05
        return cell
    }


    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch selectedIndexPath {
        case nil:
            selectedIndexPath = indexPath
        default:
            if selectedIndexPath! == indexPath {
                selectedIndexPath = nil
                print("closed")
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
    
    @IBOutlet weak var hideMe: UILabel!
    
    
}