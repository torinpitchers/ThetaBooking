//
//  HomeScreenVC.swift
//  ThetaBooking
//
//  Created by Matthew Dee on 10/02/2016.
//  Copyright © 2016 Genesis. All rights reserved.
//

import UIKit


struct menuItem {
    var name:String
    var icon:UIImage
}

let item1 = menuItem(name: "Search", icon: UIImage(named: "menuSearch")!)
let item2 = menuItem(name: "Profile", icon: UIImage(named: "menuProfile")!)
let item3 = menuItem(name: "Bookings", icon: UIImage(named: "menuBookings")!)

let items:[menuItem] = [item1,item2,item3]

class MenuItemCell : UITableViewCell {
    
    @IBOutlet var menuImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
}



class HomeScreenController: UIViewController {
    
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    @IBAction func SettingsTapped(sender: UIBarButtonItem) {
        performSegueWithIdentifier("homeToSettings", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
}


class HomeScreenTable: UITableViewController {
    
    
   

    override func viewDidLoad() {
    super.viewDidLoad()
        self.tableView.separatorStyle = .None
        Users.getInstance.load()
            
        
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
}

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return items.count
}

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
}
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15.0
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:UIView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 15))
        
        if section < items.count {
            headerView.backgroundColor = UIColor.clearColor()
            //headerView.tintColor = UIColor.clearColor()
            
            headerView.alpha = 1.0
        }
        return headerView
        
        
        
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuItemCell", forIndexPath: indexPath) as! MenuItemCell
        
        if let label = cell.nameLabel{
            label.text = items[indexPath.section].name
        }
        if let imageView = cell.menuImage {
            imageView.tintColor = UIColor(red: 0xF4 / 255.0, green: 0xFE / 255.0, blue: 0xF5 / 255.0, alpha: 0.5)
            let image:UIImage = items[indexPath.section].icon
            let image2:UIImage = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            
            imageView.image = image2
            
            
        }
        
        //cell.contentView.alpha = 0.05
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MenuItemCell
        if let label = cell.nameLabel {
            let text:String = label.text!
            
            if text == "Search"  {
                performSegueWithIdentifier("homeToSearch", sender: self)
            }
            else if text == "Profile"  {
                 performSegueWithIdentifier("HomeToProfile", sender: self)
            }
            else if text == "Bookings"{
                performSegueWithIdentifier("HomeToAppointments", sender: self)
            }
            
        }
        
    }
}

class HomeScreenSettings: UITableViewController {
    
    let settingList:[String] = ["About", "Date Display", "Delete Account", "Change Password", "Logout"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .None
        
        
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("settingsCell", forIndexPath: indexPath)
        
        if let label = cell.textLabel {
            label.text = settingList[indexPath.row]
            
            if label.text == "Logout" {
                label.textColor =  UIColor.redColor().colorWithAlphaComponent(0.8)
                label.font = UIFont.boldSystemFontOfSize(20)
            }
            else {
                label.textColor =  UIColor(red: 0xFF / 255.0, green: 0xCC / 255.0, blue: 0x00 / 255.0, alpha: 0.8)
            }
            
            
            
            
        }
       
        
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.textLabel!.text == "About" {
            performSegueWithIdentifier("settingsToAbout", sender: self)
        }
    }
    
}
