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
    let appUserDefaultManager = AppUserDefaultManager()
    let appUserAuthentication = UserAuthentication()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let appVisitCount:Int = 1 //appUserDefault.integer(forKey: "VisitCount") + 1
        if (appVisitCount == 1) {
            //let notification =
            //发送通知
        //NotificationCenter.default.post(name:kNotificationNameAgreementViewWillShow, object: nil, userInfo: nil /*Notification.userInfo*/ )
        }
        
        // for startup process
        setAppStartKeyWindow()

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
    func setAppStartKeyWindow() {
        //windowを生成
        self.window = UIWindow(frame: UIScreen.main.bounds)
        //rootViewControllerに入れる
        self.window?.rootViewController = setRootViewController()
        //表示
        self.window?.makeKeyAndVisible()
    }
    
    //MARK: - 引导页设置
    private func setRootViewController() -> UIViewController {
        if AppUtils.isAppVersionChanged() {
            _ = appUserDefaultManager.setCurrentVersion(currentVersion: AppUtils.getAppVersionInfo())
            return ViewControllerLeadpage()
        } else if !AppUtils.isUserAgreed() {
            return ViewControllerToAgreement()
        } else if !AppUtils.isUserSignined() {
            return ViewControllerToSignin()
        } else if AppUtils.isUserLocked() {
            return ViewControllerToLockOnOff()
        }
        return ViewControllerMainTabBar()
    }
    func ViewControllerLeadpage() -> UIViewController {
        let storyboard = UIStoryboard(name: kUIStoryboardName_Startup, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: kUIViewControllerId_Agreement)
    }
    func ViewControllerToAgreement() -> UIViewController {
        let storyboard = UIStoryboard(name: kUIStoryboardName_Startup, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: kUIViewControllerId_Agreement)
    }
    func ViewControllerToSignin() -> UIViewController {
        let storyboard = UIStoryboard(name: kUIStoryboardName_Startup, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: kUIViewControllerId_Signin)
    }
    func ViewControllerToLockOnOff() -> UIViewController {
        let storyboard = UIStoryboard(name: kUIStoryboardName_Startup, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: kUIViewControllerId_TouchToUnlock)
    }
    func ViewControllerMainTabBar() -> UIViewController {
        let storyboard = UIStoryboard(name: kUIStoryboardName_Main, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: kUIViewControllerId_MainTabBarVC)
    }
    ////////////////////////////////////////////////////////////////////
}

