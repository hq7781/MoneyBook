//
//  SettingViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/04/30.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit
//import AdSupport

let kNotificationNameCurrentCityChage = NSNotification.Name(rawValue:"NotificationNameCurrentCityChage")


class SettingViewController: UIViewController {
    fileprivate lazy var images: NSMutableArray! = {
        var array = NSMutableArray(array: ["score","recommend","about","feedback","removecache"])
        return array
    }()
    fileprivate lazy var titles: NSMutableArray! = {
        var array = NSMutableArray(array: ["score","recommend","about","feedback","removecache"])
        return array
    }()
    fileprivate var tableView: UITableView!
    
    //
    var cityRightButton: TextImageButton!
    
    var buttonB: UIView!
    var someView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting Table List
        setTableViewUI()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        //self.view.backgroundColor = UIColor.enixOrange() // UIColor.white
        self.setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector:#selector(onCityChange), name:kNotificationNameCurrentCityChage, object:nil)
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // self.view.removeFromSuperview()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        //接受通知监听
        NotificationCenter.default.addObserver(self, selector:#selector(onCityChange), name:kNotificationNameCurrentCityChage, object:nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("SettingViewController has destroyed", terminator: "")
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    private func setTableViewUI() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.enixColorWith(247, 247, 247, alpha: 1)
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName:"SettingCell", bundle:nil), forCellReuseIdentifier: "settingCell")
        
        view.addSubview(tableView)
    }
    
    func setUpUI() {
        self.showEasyTipViewUI()
        self.showUserVistCountInfoUI()
        self.showVersionInfoUI()
    }
    
    func showEasyTipViewUI() {
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
        let version = AppUtils.getAppVersionInfo()
        // Build番号を取得.
        let build = AppUtils.getAppBuildNumberInfo()
        // OS Version.
        let osName = AppUtils.getOSName()
        let osVersion = AppUtils.getOSVersion()
        // ID for Vender.
        let venderId = AppUtils.getVenderID()
        // ID for Ad.
        let adsId = AppUtils.getAdvertisingID()

        myLabel.text = "App:\(version) bd:\(build) OS:\(osName):\(osVersion) Vd:\(venderId) Ad:\(adsId)"
        myLabel.textColor = UIColor.red
        
        self.view.addSubview(myLabel)
    }
    func showUserVistCountInfoUI() {
        let visitCount: Int = AppUtils.getVisitCount()!
        let myLabel:UILabel = UILabel()
        
        myLabel.text = "Visited Count:\(visitCount)"
        _ = AppUtils.setVisiCount()

        myLabel.sizeToFit()
        myLabel.center = CGPoint(x:self.view.frame.width/2, y: self.view.frame.height/2)
        self.view.addSubview(myLabel)
    }
    
    func showCityChangeUI() {
        cityRightButton = TextImageButton(frame: CGRect.CGRectMake(0, 20, 80, 44))
        
        if let currentCity = AppUtils.getSelectedCity() as String? {
            cityRightButton.setTitle(currentCity, for: .normal)
        } else {
            cityRightButton.setTitle("tokyo", for: .normal)
        }
        cityRightButton.titleLabel?.font = theme.appNaviItemFont
        cityRightButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        cityRightButton.setImage(UIImage(named:"home_down"), for: .normal)
        cityRightButton.addTarget(self, action: #selector(onClickPushCityView), for:UIControlEvents.touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cityRightButton)
    }

    // received the notification
    func onCityChange(notification: NSNotification) {
        if let currentCity = notification.object as? String {
            self.cityRightButton.setTitle(currentCity, for: .normal)
        }
    }
    // received the button click event
    func onClickPushCityView() {
        let cityViewVC = CityViewController()
        cityViewVC.cityName = self.cityRightButton.title(for: .normal)
        let nav = MainNavigationController(rootViewController: cityViewVC)
        present(nav, animated: true, completion: nil)
    }
    
    //MARK: - ========== easyTipViewDelegate ==========
    func easyTipViewDidDismiss(_ easyTipView : EasyTipView) {
        print("easyTipViewDidDismiss")
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingCell.settingCellWithTableView(tableView)
        cell.setimageView.image = UIImage(named:images[indexPath.row] as! String)
        cell.titleLabel.text = titles[indexPath.row] as? String
        
        if indexPath.row == SettingCellType.clean.hashValue {
            cell.bottomView.isHidden = true
            cell.sizeLabel.isHidden = false
            cell.sizeLabel.text = String().appendingFormat("%.2f M", FileUtils.folderSize(path:appCachesPath!))
        } else {
            cell.bottomView.isHidden = false
            cell.sizeLabel.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case SettingCellType.about.hashValue:
            let aboutVC = AboutViewController()
            navigationController!.pushViewController(aboutVC, animated: true)
        case SettingCellType.recommend.hashValue:
            break
        case SettingCellType.clean.hashValue:
            weak var tmpSelf = self
            FileUtils.cleanFolder(path:appCachesPath!, complete: {
                () -> () in tmpSelf!.tableView.reloadData()
                //self.tableView.reloadData()
            })
        case SettingCellType.verinfo.hashValue:
            appShare.openURL(NSURL(string:theme.GitHubURL) as! URL)
        default:
            break
        }
    }
}

class TextImageButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel?.font = theme.appNaviItemFont
        titleLabel?.contentMode = UIViewContentMode.center
        imageView?.contentMode = UIViewContentMode.left
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect.CGRectMake(-5, 0, titleLabel!.width, height)
        imageView?.frame = CGRect.CGRectMake(titleLabel!.width + 3 - 5, 0, width - titleLabel!.width - 3, height)
    }
}
