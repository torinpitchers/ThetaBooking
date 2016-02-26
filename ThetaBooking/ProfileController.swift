//
//  ProfileControllerTableViewController.swift
//  ThetaBooking
//
//  Created by Harry Moy on 14/02/2016.
//  Copyright © 2016 Harry Moy. All rights reserved.
//

import UIKit


class ProfileCell:UITableViewCell{
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var skills: UILabel!
    @IBOutlet weak var email: UILabel!
    
}

class ProfileController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var searchResults:[User]  = Users.getInstance.getList()
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
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
        tableView.reloadData()
        print(searchResults.count)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .None
        self.searchBar.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Users.getInstance.count()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 182.0
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15.0
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:UIView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 15))
        
        if section < Users.getInstance.count() {
            headerView.backgroundColor = UIColor.clearColor()
            //headerView.tintColor = UIColor.clearColor()
            
            headerView.alpha = 1.0
        }
        return headerView
        
        
        
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ProfileCell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileCell
        if indexPath.section > searchResults.count - 1 {
          
            cell.hidden = true
            return cell
        }
        else {
           cell.hidden = false
        }
        let user = searchResults[indexPath.section]
        if let nameLabel = cell.name {
            nameLabel.text = user.name
        }
        if let emailLabel = cell.email {
            emailLabel.text = user.email
        }
        if let skillsLabel = cell.skills {
            var text:String = ""
            let skillCount:Int = user.skills.count
            var count = 0
            for skill in user.skills {
                count = count + 1
               
                if count == skillCount{
                     text = text + skill + "."
                }
                else{
                     text = text + skill + ", "
                }
            }
            skillsLabel.text = text
        }
        if let imageView = cell.profileImage {
            imageView.image = user.picture
        }
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.search(searchText)
        
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
   

    
}