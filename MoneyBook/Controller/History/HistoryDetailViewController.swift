//
//  HistoryDetailViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/04/30.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit

class HistoryDetailViewController: UIViewController {
    
    @IBOutlet weak var historyDetailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    func configureView() {
        // Update the user interface for the detail item.
        self.view.backgroundColor = UIColor.enixOrange() // UIColor.white
        if let detail = self.detailItem {
            if let label = self.historyDetailLabel {
                label.text = (detail.value(forKey: "timeStamp") as! NSObject).description
            }
        }
    }

}
