//
//  HistoryMasterViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/04/30.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit

class HistoryMasterViewController: UITableViewController
/*, recordsViewController*/ {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Event History"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        //let addButton = UIBarButtonItem()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()

    }
    /// - Parameter animated: If true, the disappearance of the view is being animated.
    override func viewWillAppear(_ animated: Bool) {
        
        self.setEditing(false, animated: animated)
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    
    // MARK: - Table view data source
    /// Asks the data source to return the number of sections in the table view.
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let event = self.eventService()
        return event.authors.count
    }
    /// Tells the data source to return the number of rows in a given section of a table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let eventService  = self.eventService()
        let author = eventService.authors[section]
        let events  = eventService.eventsByAuthor[author]
        
        return (events?.count)!
    }
    /// Asks the data source for the title of the header of the specified section of the table view.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let eventService = self.eventService()
        return eventService.authors[section]
    }
    /// Asks the data source for a cell to insert in a particular location of the table view.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryEventCell", for: indexPath)

        // Configure the cell...
        let label = cell.viewWithTag(1) as! UILabel
        let event  = self.eventAtIndexPath(indexPath: indexPath)
        label.text = event.title

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            let eventService = self.eventService()
            let event = self.eventAtIndexPath(indexPath: indexPath)
            if eventService.remove(event: event) {
                self.tableView.reloadData()
            }
                
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            tableView.insertRows(at: [indexPath], with: .fade)
            let eventService = self.eventService()
            let event = self.eventAtIndexPath(indexPath: indexPath)
            if eventService.add(event: event) {
                self.tableView.reloadData()
            }
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    // MARK: get event
    /// - Get the event at index path.
    /// - Parameter indexPath: An index path locating a row in tableView.
    /// - Returns: Event data.
    private func eventAtIndexPath(indexPath: IndexPath) -> Event {
        let eventService  = self.eventService()
        let author = eventService.authors[indexPath.section]
        let events = eventService.eventsByAuthor[author]
        
        return events![indexPath.row]
    }
    
    /// - Get the event data
    /// - Returns: Instance of the event Service.
    func eventService() -> EventService {
        let app = UIApplication.shared.delegate as! AppDelegate

        return app.appDatabaseManager.eventService
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
