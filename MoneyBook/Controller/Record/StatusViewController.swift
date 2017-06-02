//
//  StatusViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/01.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit

let D_statusVC_name = "StatusVC"

class StatusViewController: UIViewController {
    //MARK: - ==========  var define ==========
    var delegate : RecordsViewControllerDelegate? = nil
    
    @IBOutlet var tfStatus: UITextField!

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
    @IBAction func doneDidTap(_ sender: UIButton) {
        self.delegate?.sendValue(value: tfStatus.text!, view: D_statusVC_name)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backDidTap(_ sender: UIButton) {
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
