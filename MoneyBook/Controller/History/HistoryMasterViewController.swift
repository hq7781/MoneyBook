//
//  HistoryMasterViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/04/30.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit

class HistoryMasterViewController: UITableViewController {
    
    var calendarButton: TextImageButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Event History"
        self.view.backgroundColor = UIColor.enixOrange() // UIColor.white
        //self.view.backgroundColor = UIColor.white
        setupUI()
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


    // MARK: get event
    /// - Get the event at index path.
    /// - Parameter indexPath: An index path locating a row in tableView.
    /// - Returns: Event data.
    fileprivate func eventAtIndexPath(indexPath: IndexPath) -> Event {
        let eventService  = self.eventService()
        let userName = eventService.userList[indexPath.section]
        let events = eventService.eventsByUser[userName]
        
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
    func setupUI() {

        self.navigationItem.leftBarButtonItem = self.editButtonItem

        //let addButton = UIBarButtonItem()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //showCalendarViewUI()
    }
    
    func showCalendarViewUI() {
        calendarButton = TextImageButton(frame: CGRect.CGRectMake(40, 300, 80, 44))

        calendarButton.setTitle("Calendar", for: .normal)
        calendarButton.titleLabel?.font = theme.appNaviItemFont
        calendarButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        calendarButton.setImage(UIImage(named:"home_down"), for: .normal)
        calendarButton.addTarget(self, action: #selector(onClickPushCalendarView),
                            for:UIControlEvents.touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: calendarButton)
    }
    
    func onClickPushCalendarView() {
        let calendarViewVC = CalendarViewController()
        let nav = MainNavigationController(rootViewController: calendarViewVC)
        present(nav, animated: true, completion: nil)
    }
}

//MARK: - ========== UITableViewDelegate, UITableViewDataSource ==========
extension HistoryMasterViewController {
    // MARK: - Table view data source
    /// Asks the data source to return the number of sections in the table view.
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let event = self.eventService()
        return event.userList.count
    }
    /// Tells the data source to return the number of rows in a given section of a table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let eventService  = self.eventService()
        let userName = eventService.userList[section]
        let events  = eventService.eventsByUser[userName]
        
        return (events?.count)!
    }
    /// Asks the data source for the title of the header of the specified section of the table view.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let eventService = self.eventService()
        return eventService.userList[section]
    }
    /// Asks the data source for a cell to insert in a particular location of the table view.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryEventCell", for: indexPath)
        
        // Configure the cell...
        let typeLabel = cell.viewWithTag(0) as! UILabel
        let titleLabel = cell.viewWithTag(1) as! UILabel
        let paymentLabel = cell.viewWithTag(2) as! UILabel
        let dateLabel = cell.viewWithTag(3) as! UILabel
        let event  = self.eventAtIndexPath(indexPath: indexPath)
        typeLabel.text = event.eventType ? "InCome":"Expend"
        titleLabel.text = event.eventMemo
        paymentLabel.text = String("¥¥: \(event.eventPayment)")
        
        let formatter = DateFormatter()
        let jaLocale = Locale(identifier: "ja_JP")
        formatter.locale = jaLocale
        formatter.dateFormat = "yyyy年MM月dd日 HH時mm分"
        dateLabel.text = formatter.string(for: event.recodedDate)
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
}
