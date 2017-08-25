//
//  AboutViewController.swift
//  MoneyBook
//
//  Created by HONGQUAN on 8/14/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI ()
        AppUtils.googleTracking("AbountView")
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
        self.view.backgroundColor = UIColor.yellow
        title = "About Me"
        self.showVersionInfoUI()
        self.showOpreationView()
    }
    
    //
    func showVersionInfoUI() {
        // 画面右下に表示.
        let versionInfoLabel: UILabel = UILabel()
        let labelWidth: CGFloat = 360
        let labelHeight: CGFloat = 20
        let posX: CGFloat = self.view.bounds.width - labelWidth
        let posY: CGFloat = self.view.bounds.height - labelHeight - 200
        versionInfoLabel.frame = CGRect(x: posX, y: posY, width: labelWidth, height: labelHeight)
        
        // Versionを取得.
        let version = AppUtils.getAppVersionInfo()
        // Build番号を取得.
        let build = AppUtils.getAppBuildNumberInfo()
        // OS Version.
        let osName = AppUtils.getOSName()
        let osVersion = AppUtils.getOSVersion()
        // ID for Vender.
        //let venderId = AppUtils.getVenderID()
        // ID for Ad.
        //let adsId = AppUtils.getAdvertisingID()
        //myLabel.text = "App:\(version) bd:\(build) OS:\(osName):\(osVersion) Vd:\(venderId) Ad:\(adsId)"
        versionInfoLabel.text = "App Ver:\(version) build No:\(build) OS:\(osName):\(osVersion)"
        versionInfoLabel.textColor = UIColor.red

        self.view.addSubview(versionInfoLabel)
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
        self.dismiss(animated: true, completion: nil)
    }
}
