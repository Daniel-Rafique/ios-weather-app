//
//  SavedLocationsTableViewController.swift
//  Swift Weather
//
//  Created by Daniel Rafique - Black on 24/11/2014.
//  Copyright (c) 2014 Daniel Rafique. All rights reserved.
//

import UIKit

class SavedLocationsTableViewController: UITableViewController {
    
    var savedLocations : [NSString]{
        get{
            var returnValue : [NSString]? = NSUserDefaults.standardUserDefaults().objectForKey("locationData") as? [NSString]
            if returnValue == nil{
                
                returnValue = ["Los Angeles", "Toronto", "New York"]
            }
            
            return returnValue!
        }
        set (newLcationData){
            
            NSUserDefaults.standardUserDefaults().setObject(newLcationData, forKey: "locationData")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }   //getting and setting a property
    var tempLocation: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //savedLocations = ["London", "Los Angeles", "Toronto", "New York"]
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "savedLocationsBackground"))


    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return savedLocations.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("savedLocationCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel.text = savedLocations[indexPath.row]
            
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    var cellBackround = UIColor.whiteColor().colorWithAlphaComponent(0.08)
        cell.backgroundColor = cellBackround
        cell.backgroundColor = UIColor.clearColor()
        
        if indexPath.row % 2 != 0 {
            cell.backgroundColor = UIColor.clearColor()
        }
    }
    
    @IBAction func didPressSaveLocation(sender: AnyObject) {
        
        if !contains(savedLocations, tempLocation!){
            savedLocations.insert(tempLocation!, atIndex: 0)
            print(savedLocations)
        }
        else{
            var alert = UIAlertController(title: "Duplicate Location", message: "The location is already saved", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        self.tableView.reloadData()
    }
}
