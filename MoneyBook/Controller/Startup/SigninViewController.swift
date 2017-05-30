//
//  SigninViewController.swift
//  MoneyBook
//
//  Created by Roan Hong on 2017/5/30.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
    var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        self.setMyLabel(text: "Sign in Please!", point: CGPoint(x: 0, y: 300))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func setMyLabel(text: NSString, point: CGPoint){
        //let
        myLabel = UILabel(frame: CGRect(x: point.x, y: point.y, width:self.view.bounds.width, height:50))
        myLabel.backgroundColor = UIColor.orange
        myLabel.layer.masksToBounds = true
        myLabel.layer.cornerRadius = 10.0
        myLabel.textColor = UIColor.white
        myLabel.shadowColor = UIColor.gray
        myLabel.textAlignment = NSTextAlignment.center
        myLabel.font = UIFont.systemFont(ofSize: 14)
        myLabel.text = text as String
        myLabel.numberOfLines = 2
        
        self.view.addSubview(myLabel)
    }

}
