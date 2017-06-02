//
//  SpentViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/01.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit

let D_spentVC_name = "SpentVC"


protocol SpentViewControllerDelegate {
    func reloadData()
}

class SpentViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, SpentViewControllerDelegate {
    //MARK: - ========== internal methods ==========
    internal func reloadData() {
    //    data = DB.share().queryIndex()
        //print(data)
        tableView.reloadData()
    }
    //MARK: - ==========  var define ==========
    var delegate : RecordsViewControllerDelegate? = nil
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet var backButton: UIButton!
    //var data = DB.share().queryIndex()
    
    //MARK: - ========== override methods ==========
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - ========== Init methods ==========
    //MARK: - ========== IBACtions ==========
    @IBAction func backDidTap(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func addDidTap(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: D_addSpentVC_name) as! AddSpentViewController

        secondViewController.delegate = self as SpentViewControllerDelegate
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    //MARK: - ========== UITableViewDelegate ==========
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7 //data.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "name"//data[section].dadName
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 //data[section].childName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ElementCell")
        cell.textLabel?.text = "element"//data[indexPath.section].childName[indexPath.row].childName
        cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size: 16)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        print(currentCell.textLabel!.text!)
        self.delegate?.sendValue(value: (currentCell.textLabel?.text)!, view: D_spentVC_name)
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
