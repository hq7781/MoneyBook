//
//  AboutViewController.swift
//  MoneyBook
//
//  Created by HONGQUAN on 8/14/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    init() {
        super.init(nibName:"AboutViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(nibName:"AboutViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI ()
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
    func setupUI() {
        navigationItem.title = "About Me"
    }
}
