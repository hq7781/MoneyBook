//
//  TouchToUnlockViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/5/30.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit
import LocalAuthentication

@available(iOS 8.0, *)
class TouchToUnlockViewController: UIViewController {
    // 認証用コンテキスト.
    var mySecurityLabel : UILabel!
    var myButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showDefaultUserView()
        self.showOpreationView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)

        NotificationCenter.default.addObserver(self, selector: #selector(OnUserAuthencationSuccessed),
                                               name: kNotificationNameUserAuthencationSuccessed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(OnUserAuthencationFailed),
                                               name: kNotificationNameUserAuthencationFailed, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - show Default User View
    func showDefaultUserView() {
        // 背景色を設定.
        self.view.backgroundColor = UIColor.white
        
        mySecurityLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        mySecurityLabel.backgroundColor = UIColor.orange
        mySecurityLabel.layer.masksToBounds = true
        mySecurityLabel.layer.cornerRadius = 75.0
        mySecurityLabel.textColor = UIColor.white
        mySecurityLabel.shadowColor = UIColor.gray
        mySecurityLabel.font = UIFont.systemFont(ofSize: CGFloat(30))
        mySecurityLabel.textAlignment = NSTextAlignment.center
        mySecurityLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y: 300)
        self.view.addSubview(mySecurityLabel)
        
        myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        myButton.backgroundColor = UIColor.blue
        myButton.setTitle("認証開始", for: UIControlState())
        myButton.setTitleColor(UIColor.white, for: UIControlState())
        myButton.layer.masksToBounds = true
        myButton.layer.cornerRadius = 20.0
        myButton.layer.position = CGPoint(x: self.view.bounds.width / 2, y:self.view.bounds.height-200)
        myButton.addTarget(self, action: #selector(self.checkSuccess), for: .touchUpInside)
        self.view.addSubview(myButton)
    }
    
    // MARK: - show Opreation View
    func showOpreationView() {
        // ボタンを作成.
        let backButton: UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 120,height: 50))
        backButton.backgroundColor = UIColor.red;
        backButton.setTitle("Back", for: UIControlState())
        backButton.setTitleColor(UIColor.white, for: UIControlState())
        backButton.layer.masksToBounds = true
        backButton.layer.cornerRadius = 20.0
        backButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-100)
        backButton.addTarget(self, action: #selector(self.onClickBackButton(_:)), for: .touchUpInside)
        self.view.addSubview(backButton);
    }
    func onClickBackButton(_ sender: UIButton){
        let storyboard = UIStoryboard(name: kUIStoryboardName_Startup, bundle: nil)
        let backView = storyboard.instantiateViewController(withIdentifier:kUIViewControllerId_Signin)
        
        backView.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        self.present(backView, animated: true, completion: nil)
    }
    
    func showOKAlert() {
        let alertController = UIAlertController(title:"成功", message:"認証に成功しました", preferredStyle:.alert)
        let okButton:UIAlertAction = UIAlertAction(title: "OK",style: UIAlertActionStyle.default,handler:{(action:UIAlertAction!) -> Void in
            let storyboard = UIStoryboard(name: kUIStoryboardName_Main, bundle: nil)
            let nextView = storyboard.instantiateViewController(withIdentifier:kUIViewControllerId_MainTabBarVC) as! UITabBarController
            self.present(nextView, animated: true, completion: nil)
        })
        
        alertController.addAction(okButton)
        present(alertController, animated: true, completion:nil)
    }
    
    func checkSuccess() {
        self.updateMySecurityLabel(nil)
        let tryCount = 2
        let userInfo = [kNotificationUserInfoKey_UserTryLimit : "\(tryCount)"]
        NotificationCenter.default.post(name:kNotificationNameUserAuthencationStart, object: nil, userInfo: userInfo )
    }

    func OnUserAuthencationSuccessed(notification: NSNotification) {
        DispatchQueue.main.async(execute: {
            self.updateMySecurityLabel("認証成功")
            self.showOKAlert()
        })
    }
    func OnUserAuthencationFailed(notification: NSNotification) {
        let userInfo = notification.userInfo
        DispatchQueue.main.async(execute: {
            let errorMessage = userInfo?[kNotificationUserInfoKey_ErrorMessage] as? String
            if errorMessage != nil {
                self.updateMySecurityLabel(errorMessage)
            }
        })
    }
    
    func updateMySecurityLabel(_ message: String?) {
        DispatchQueue.main.async(execute: {
            if message != nil {
                self.mySecurityLabel.text = message
            } else {
                self.mySecurityLabel.text = ""
            }
        })
    }

}
