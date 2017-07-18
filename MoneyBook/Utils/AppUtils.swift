//
//  AppUtils.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/17.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//
import UIKit
import Foundation

public class AppUtils {
    
    static func getAppVersionInfo() -> String {
        // Versionを取得.
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        return version
    }
    static func getAppBuildNumberInfo() -> String {
        // Build番号を取得.
        let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
        return build
    }
    
    static func isAppVersionChanged() ->Bool {
        //let versionStr = "CFBundleShortVersionString"
        //let cureentVersion = NSBundle.mainBundle().infoDictionary![versionStr] as! String
        //let oldVersion = (NSUserDefaults.standardUserDefaults().objectForKey(versionStr) as? String) ?? ""
        let cureentVersion = getAppVersionInfo()
        let app = UIApplication.shared.delegate as! AppDelegate
        let oldVersion = app.appUserDefaultManager.getCurrentVerion()
        
        return (cureentVersion.compare(oldVersion!) != ComparisonResult.orderedDescending)
    }
    static func isUserVisited() ->Bool {
        let app = UIApplication.shared.delegate as! AppDelegate
        let vistedCount = app.appUserDefaultManager.getVisitCount()
        if vistedCount > 0 {
            return true
        } else {
            return false
        }
    }

    static func isUserAgreed() ->Bool {
        #if DEBUG
        return true // for debug
        #else
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.appUserDefaultManager.getUserAgreement()
        #endif
    }
    /*
    static func isUserSignined() ->Bool {
        #if DEBUG
        return true // for debug
        #else
        let app = UIApplication.shared.delegate as! AppDelegate
        let currentUser = app.appUserDefaultManager.getCurrentUser()
        if (currentUser == nil) || (currentUser == "") {
            return false
        } else {
            return true
        }
        #endif
    }*/
    // get login status
    class func isUserLogin() -> Bool {
        #if DEBUG
        return true // for debug
        #else
        let app = UIApplication.shared.delegate as! AppDelegate
        let account = app.appUserDefaultManager.getUserAccount()
        let password = app.appUserDefaultManager.getUserPassword()
            
        if account != nil && password != nil {
            if !account!.isEmpty && !password!.isEmpty {
                return true
            }
        }
        return false
        #endif
    }
    static func isUserLocked() ->Bool {
        #if DEBUG
        return false // for debug
        #else
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.appUserDefaultManager.getUserLock()
        #endif
    }
}

extension UIViewController {
    public func getVersionInfo() {
        self.getVersionInfo()
    }
    public func getBuildNumberInfo() {
        self.getVersionInfo()
    }
    
    //MARK: - ========== extension ==========
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}
