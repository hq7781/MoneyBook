//
//  SettingViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/04/30.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit
import AdSupport

class SettingViewController: UIViewController {

    var buttonB: UIView!
    var someView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        //self.view.backgroundColor = UIColor.enixOrange() // UIColor.white
        self.setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // self.view.removeFromSuperview()
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
    func setUpUI() {
        buttonB = UIView(frame: CGRectMake(30, 30, 50, 35))
        //buttonB = UIButton(frame: CGRectMake(0, 30, 50, 35))
        //buttonB.setTitle(title: "buttonB", state: UIControlState.normal)
        buttonB.backgroundColor = UIColor.red
        self.view.addSubview(buttonB)
        
        someView = UIView(frame: CGRectMake(30, 200, 300, 60))
        someView.backgroundColor = UIColor.yellow
        self.view.addSubview(someView)
        
        var preferences = EasyTipView.Preferences()
        preferences.animating.dismissDuration = 6.0
        preferences.drawing.font = UIFont(name: "Futura-Medium", size: 13)!
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
        EasyTipView.globalPreferences = preferences
        
        EasyTipView.show(forView: self.buttonB,
                         withinSuperview: self.navigationController?.view,
                         text: "Tip view inside the navigation controller's view. Tap to dismiss!",
                         preferences: preferences,
                         delegate: self as? EasyTipViewDelegate)
        
        let tipView = EasyTipView(text: "Some text...........", preferences: preferences)
        tipView.show(forView: self.someView, withinSuperview: self.navigationController?.view)
        
        // later on you can dismiss it
        tipView.dismiss()
        self.showUserVistCountInfoUI()
        self.showVersionInfoUI()

    }
    
    func showVersionInfoUI() {
        // 画面右下に表示.
        let myLabel: UILabel = UILabel()
        let labelWidth: CGFloat = 360
        let labelHeight: CGFloat = 20
        let posX: CGFloat = self.view.bounds.width - labelWidth
        let posY: CGFloat = self.view.bounds.height - labelHeight - 100
        myLabel.frame = CGRect(x: posX, y: posY, width: labelWidth, height: labelHeight)
        
        // Versionを取得.
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        // Build番号を取得.
        let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
        
        // OS Version.
        let mySystemName = UIDevice.current.systemName
        let mySystemVersion = UIDevice.current.systemVersion

        // ID for Vender.
        let myIDforVender = UIDevice.current.identifierForVendor
        // ID for Ad.
        let myASManager = ASIdentifierManager()
        let myIDforAd = myASManager.advertisingIdentifier

        myLabel.text = "App:\(version) bd:\(build) OS:\(mySystemName):\(mySystemVersion) Vd:\(String(describing: myIDforVender)) Ad:\(String(describing: myIDforAd))"
        myLabel.textColor = UIColor.red
        
        self.view.addSubview(myLabel)
    }
    func showUserVistCountInfoUI() {
        //UserDefaultの生成.
        let myUserDefault:UserDefaults = UserDefaults()
        let visitcount:Int = myUserDefault.integer(forKey: "VisitCount")
        let openCount:Int  = myUserDefault.integer(forKey: "OpenCount")
        let myLabel:UILabel = UILabel()
        
        myLabel.text = "Visited Count:\(visitcount) ¥n Opened Count:\(openCount) !"
        //+1した値を登録する
        myUserDefault.set((visitcount + 1), forKey: "VisitCount")
        myUserDefault.set((openCount + 1), forKey: "OpenCount")
        
        myLabel.sizeToFit()
        myLabel.center = CGPoint(x:self.view.frame.width/2, y: self.view.frame.height/2)
        self.view.addSubview(myLabel)
    }
    
    //MARK: - ========== easyTipViewDelegate ==========
    func easyTipViewDidDismiss(_ easyTipView : EasyTipView) {
        print("easyTipViewDidDismiss")
    }
    
    //MARK: - ========== privete ==========
//    override func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
//        return CGRect(x: x, y: y, width: width, height: height)
//    }
}
