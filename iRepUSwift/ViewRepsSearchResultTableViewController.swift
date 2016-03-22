//
//  ViewRepsSearchResultTableViewController.swift
//  iRepUSwift
//
//  Created by Jaime Moises Gutierrez on 3/19/16.
//  Copyright © 2016 MoiGtz. All rights reserved.
//

import UIKit

class ViewRepsSearchResultTableViewController: UITableViewController {

    var repsToShowArray:[Representative]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewDidAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.repsToShowArray?.count{
            if count == 0 {
                let emptyLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
                emptyLabel.font = UIFont.boldSystemFontOfSize(24)
                emptyLabel.textAlignment = NSTextAlignment.Center
                emptyLabel.text = "No reps were found"
                emptyLabel.numberOfLines = 0
                emptyLabel.textColor = Constants.WhoIsMyRepDarkGrayColor
                self.tableView.backgroundView = emptyLabel
                self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
                return 0
            } else {
                self.tableView.backgroundView = nil
                return count
            }
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reppCell", forIndexPath: indexPath)

        let rep = self.repsToShowArray![indexPath.row] as Representative
        
        cell.textLabel?.text = "\(rep.name!)"
        cell.detailTextLabel?.text = "\(rep.state!)"

        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowProfile"{
            if let vc = segue.destinationViewController as? ProfileTableViewController{
                vc.rep = repsToShowArray![(self.tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
