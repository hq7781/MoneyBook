//
//  ParentViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/01.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit
let D_ParentVC_name = "ParentVC"

class ParentViewController: UIViewController {
    //MARK: - ==========  var define ==========
    var delegate : AddSpentViewControllerDelegate? = nil
    //let data = DB.share().queryIndex()

    @IBOutlet var tableView: UITableView!
    
    //MARK: - ========== override methods ==========
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - ========== IBACtions ==========
    @IBAction func backButton(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    //MARK: - ========== UITableViewDelegate ==========
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 //data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ParentCell")
        cell.textLabel?.text = "Parent"//data[indexPath.row].dadName
        cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size: 16)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        
        print(currentCell.textLabel!.text!)
        self.delegate?.setData(str: currentCell.textLabel!.text!)
        _ = self.navigationController?.popViewController(animated: true)
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
