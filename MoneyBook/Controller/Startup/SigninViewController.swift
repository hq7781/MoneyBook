//
//  SigninViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/5/30.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit
import LineSDK  // for Line Login

class SigninViewController: UIViewController {

    var hintLabel: UILabel!
    @IBOutlet weak var signinLabel: UILabel!
    @IBOutlet weak var signinButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white

        self.showDefaultUserView()
        self.showOpreationView()
        AppUtils.googleTracking("SigninView")
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
    func showDefaultUserView() {
        self.setSinginLabel(text: "Sign in", point: CGPoint(x: self.view.bounds.width/2, y: 300))
        self.setHintLabel(text: "Sign in Please!", point: CGPoint(x: 0, y: 50))
        self.setSinginButton()
    }
    func setSinginLabel(text: NSString, point: CGPoint) {
        // 背景色を設定.
        signinLabel.backgroundColor = UIColor.orange
        signinLabel.layer.masksToBounds = true
        signinLabel.layer.cornerRadius = 75.0
        signinLabel.textColor = UIColor.white
        signinLabel.shadowColor = UIColor.gray
        signinLabel.font = UIFont.systemFont(ofSize: CGFloat(30))
        signinLabel.textAlignment = NSTextAlignment.center
        signinLabel.layer.position = point
    }
    func setHintLabel(text: NSString, point: CGPoint) {
        hintLabel = UILabel(frame: CGRect(x: point.x, y: point.y, width:self.view.bounds.width, height:50))
        hintLabel.backgroundColor = UIColor.orange
        hintLabel.layer.masksToBounds = true
        hintLabel.layer.cornerRadius = 10.0
        hintLabel.textColor = UIColor.white
        hintLabel.shadowColor = UIColor.gray
        hintLabel.textAlignment = NSTextAlignment.center
        hintLabel.font = UIFont.systemFont(ofSize: 14)
        hintLabel.text = text as String
        hintLabel.numberOfLines = 2
        
        self.view.addSubview(hintLabel)
    }

    func setSinginButton() {
        //let signinButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        signinButton.backgroundColor = UIColor.blue
        signinButton.setTitle("ログイン", for: UIControlState())
        signinButton.setTitleColor(UIColor.white, for: UIControlState())
        signinButton.layer.masksToBounds = true
        signinButton.layer.cornerRadius = 20.0
        signinButton.layer.position = CGPoint(x: self.view.bounds.width / 2, y:self.view.bounds.height-200)
        //signinButton.addTarget(self, action: #selector(self.checkSuccess), for: .touchUpInside)
        //self.view.addSubview(signinButton)
    }
    
    // MARK: - show Opreation View
    func showOpreationView() {
        // Line Login Button
        let lineLoginButton: UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 120,height: 50))
        lineLoginButton.backgroundColor = UIColor.green;
        lineLoginButton.setTitle("Line Login", for: UIControlState())
        lineLoginButton.setTitleColor(UIColor.white, for: UIControlState())
        lineLoginButton.layer.masksToBounds = true
        lineLoginButton.layer.cornerRadius = 20.0
        lineLoginButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        lineLoginButton.addTarget(self, action: #selector(self.onClickLineLoginButton(_:)), for: .touchUpInside)
        self.view.addSubview(lineLoginButton);
        
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
    
    func onClickLineLoginButton(_ sender: UIButton){
        LineSDKLogin.sharedInstance().delegate = self
        LineSDKLogin.sharedInstance().start()
    }
    
    func onClickBackButton(_ sender: UIButton){
        let storyboard = UIStoryboard(name: kUIStoryboardName_Startup, bundle: nil)
        let prevViewController = storyboard.instantiateViewController(withIdentifier:kUIViewControllerId_Agreement)
        
        prevViewController.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        self.present(prevViewController, animated: true, completion: nil)
    }
}

extension SigninViewController: LineSDKLoginDelegate {
    // https://clickan.click/line-login-swift/
    func didLogin(
        _ login: LineSDKLogin,
        credential: LineSDKCredential?,
        profile: LineSDKProfile?,
        error: Error?
        ) {
        if let _error = error {
            print("error: \(_error.localizedDescription)")
            // 1. キャンセルあるいは設定ミスなどによりログインできなかった場合の処理
            return
        }
        
        guard let _credential = credential,
            let _profile = profile else {
                print("Failed to login by Line. credential or profile is nil.")
                return
        }
        
        guard let accessToken = _credential.accessToken?.accessToken as String? else {
            print("Failed to login by Line. accessToken is not as String.")
            return
        }
        print("accessToken: \(accessToken)")
        
        let userName = _profile.displayName
        let userId = _profile.userID
        print("UserName: \(userName), UserId: \(userId)")
        
        // 2. 後はお好きにログインすべし
        let storyboard = UIStoryboard(name: kUIStoryboardName_Startup, bundle: nil)
        let prevViewController = storyboard.instantiateViewController(withIdentifier:kUIViewControllerId_Agreement)
        
        prevViewController.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        self.present(prevViewController, animated: true, completion: nil)
    }
}
