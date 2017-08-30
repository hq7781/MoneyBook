//
//  AccountViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/01.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit
let D_fromAccVC_name = "AccountVC"
let k_CELLNAME_AccountTableViewCell: String = "cellChose"

class AccountViewController: UIViewController {
    //MARK: - ==========  var define ==========
    var delegate : RecordsViewControllerDelegate? = nil
    
    @IBOutlet var tableView: UITableView!
    
    //var data = DB.share().queryAccount()
    
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
    @IBAction func addAccountButton(_ sender: UIButton) {
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

/// MARK: - , UITableViewDelegate, UITableViewDataSource
extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - ========== UITableViewDelegate ==========
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6 //data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: k_CELLNAME_AccountTableViewCell, for: indexPath) as? AccountTableViewCell
        cell?.imgAcc.image = nil //UIImage(named: data[indexPath.row].image)
        cell?.lblMoney.text = "Value" //"Value: \(data[indexPath.row].money) Yen"
        cell?.lblNameAcc.text = "name" // data[indexPath.row].nameAcc
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        //  let currentCell = tableView.cellForRow(at: indexPath!)! as! AccountTableViewCell
        _ = tableView.cellForRow(at: indexPath!)! as! AccountTableViewCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height / 12
    }
}
