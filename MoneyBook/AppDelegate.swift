//
//  AppDelegate.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/04/30.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit
import StoreKit // for Purchase
import LineSDK  // for Line Login
import Google   // for Google Analytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PaymentManagerDelegate {

    var window: UIWindow?
    
    public let app = UIApplication.shared.delegate as? AppDelegate

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
        // for Google service process
        setAppGoogleService()
        
        // for Purchase process
        setAppPurchase()
        
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
    // from line Login callback handling
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if LineSDKLogin.self != nil { // Line Login
            return LineSDKLogin.sharedInstance().handleOpen(url)
        } else {
            return GIDSignIn.sharedInstance().handle(url,
                                sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        }
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
        } else if !AppUtils.isUserLogin() {
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
    func setAppGoogleService() {
        // configure tracker from GoogleService-Info.plist
        var configureError : NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services:\(String(describing: configureError))")
        // Initialize Google sing-in Crash!!!!!!
        //GIDSignIn.sharedInstance().delegate = self as! GIDSignInDelegate
        
        // Optional: configure GAI options.
        let gai = GAI.sharedInstance()
        gai?.trackUncaughtExceptions = true // report uncaught exceptions
        gai?.logger.logLevel = GAILogLevel.verbose //remove before app release
    }
    
    func setAppPurchase() {
        // 
        PaymentManager.shared().delegate = self
        SKPaymentQueue.default().add(PaymentManager.shared())
        //
        PaymentManager.checkReceipt()
        //return true
    }
}


