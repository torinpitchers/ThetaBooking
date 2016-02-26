//
//  TableViewController.swift
//  ThetaBooking
//
//  Created by Torin Pitchers on 12/02/2016.
//  Copyright © 2016 Harry Moy. All rights reserved.
//

import UIKit
import Foundation



class TableViewController: UITableViewController, UISearchBarDelegate {
    var fetchedResults:[String] = ["mark tyers" , "reda" , "matthew copson"]
    var searchResults:[String]  = ["mark tyers" , "reda" , "matthew copson"]
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.title = "Search"
        
        
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
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResults.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mycell", forIndexPath: indexPath)
        
        if let label = cell.textLabel{
            label.text = searchResults[indexPath.row]
        }
        return cell
    }
    
    func search(text:String) {
        searchResults = [] //empty the search results container
        let searchRange = Range(start: text.startIndex, end: text.endIndex) //calulate range of search
        
        
        for person in fetchedResults {
            if searchRange.count > person.characters.count {
                continue
            }
            let substring = person.substringWithRange(searchRange) //get substring from range
            if substring.lowercaseString == text.lowercaseString {
                searchResults.append(person)
                
            }
        }
        tableView.reloadData()
    }
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.search(searchText)
        
    }
    
    
}