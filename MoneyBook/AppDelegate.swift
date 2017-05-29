//
//  AppDelegate.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/04/30.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /// Manager fot the application data. SQLite3 Database
    let appDatabaseManager = AppDatabaseManager()
    
    /// Manager fot the application UserDefault data. Info.plist
    var appUserDefault:UserDefaults = UserDefaults()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let appVisitCount:Int = 1 //appUserDefault.integer(forKey: "VisitCount") + 1
        if (appVisitCount == 1) {
            //let notification =
            //发送通知
        //NotificationCenter.default.post(name:kNotificationNameAgreementViewWillShow, object: nil, userInfo: nil /*Notification.userInfo*/ )
        } else {
        }
        appUserDefault.set(appVisitCount,forKey:"VisitCount")
        /////// for startup process
        //self.checkAgreement()
        self.checkSignin()
        //self.checkLockOnOff()
        //////
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    ////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////
    func checkAgreement() {
        let appUserDefault:UserDefaults = UserDefaults()
        let agreementFlag:Bool = appUserDefault.bool(forKey: "AgreementFlag")
        //appUserDefault.set(agreementFlag,forKey:"AgreementFlag")
        
        //個人情報同意がない場合同意提示画面に遷移
        if (agreementFlag == false) {
            //windowを生成
            self.window = UIWindow(frame: UIScreen.main.bounds)
            //Storyboardを指定
            let storyboard = UIStoryboard(name: "Startup", bundle: nil)
            //Viewcontrollerを指定
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "Agreement")
            //rootViewControllerに入れる
            self.window?.rootViewController = initialViewController
            //表示
            self.window?.makeKeyAndVisible()
        }else{
            //同意済みの場合その他処理、例え：Storyboardでチェックの入っているIs Initial View Controllerに遷移する
        }
    }
    func checkSignin() {
        let appUserDefault:UserDefaults = UserDefaults()
        let currentUser:String? = appUserDefault.string(forKey: "CurrentUser")
        //appUserDefault.set(currentUser,forKey:"CurrentUser")
        
        //ユーザーがいない場合サインイン画面に遷移
        if (currentUser == nil){
            //windowを生成
            self.window = UIWindow(frame: UIScreen.main.bounds)
            //Storyboardを指定
            let storyboard = UIStoryboard(name: "Startup", bundle: nil)
            //Viewcontrollerを指定
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "Signin")
            //rootViewControllerに入れる
            self.window?.rootViewController = initialViewController
            //表示
            self.window?.makeKeyAndVisible()
        }else{
            //ユーザーがいる場合Storyboardでチェックの入っているIs Initial View Controllerに遷移する
        }
    }
    func checkLockOnOff() {
        let appUserDefault:UserDefaults = UserDefaults()
        let lockOnOffFlag:Bool = appUserDefault.bool(forKey: "LockOnOffFlag")
        //appUserDefault.set(lockOnOffFlag,forKey:"AgreementFlag")
        
        //ユーザーがいない場合サインイン画面に遷移
        if (lockOnOffFlag == true){
            //windowを生成
            self.window = UIWindow(frame: UIScreen.main.bounds)
            //Storyboardを指定
            let storyboard = UIStoryboard(name: "Startup", bundle: nil)
            //Viewcontrollerを指定
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "TouchToUnlock")
            //rootViewControllerに入れる
            self.window?.rootViewController = initialViewController
            //表示
            self.window?.makeKeyAndVisible()
        }else{
            //ユーザーがいる場合Storyboardでチェックの入っているIs Initial View Controllerに遷移する
        }
    }

}

