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
    
    @IBOutlet weak var labelSignin: UILabel!
    @IBOutlet weak var buttonSignin: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        

        self.showDefaultUserView()
        self.showOpreationView()
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
        // 背景色を設定.
        labelSignin.backgroundColor = UIColor.orange
        labelSignin.layer.masksToBounds = true
        labelSignin.layer.cornerRadius = 75.0
        labelSignin.textColor = UIColor.white
        labelSignin.shadowColor = UIColor.gray
        labelSignin.font = UIFont.systemFont(ofSize: CGFloat(30))
        labelSignin.textAlignment = NSTextAlignment.center
        labelSignin.layer.position = CGPoint(x: self.view.bounds.width/2, y: 300)
        
        self.setMyLabel(text: "Sign in Please!", point: CGPoint(x: 0, y: 50))

        //let buttonSignin: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        buttonSignin.backgroundColor = UIColor.blue
        buttonSignin.setTitle("ログイン", for: UIControlState())
        buttonSignin.setTitleColor(UIColor.white, for: UIControlState())
        buttonSignin.layer.masksToBounds = true
        buttonSignin.layer.cornerRadius = 20.0
        buttonSignin.layer.position = CGPoint(x: self.view.bounds.width / 2, y:self.view.bounds.height-200)
        //buttonSignin.addTarget(self, action: #selector(self.checkSuccess), for: .touchUpInside)
        //self.view.addSubview(buttonSignin)
    }
    
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
        let prevViewController = storyboard.instantiateViewController(withIdentifier:kUIViewControllerId_Agreement)
        
        prevViewController.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        self.present(prevViewController, animated: true, completion: nil)
    }
}
