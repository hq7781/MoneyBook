//
//  AppUtils.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/17.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//
import UIKit
import AdSupport
import Foundation

public class AppUtils {
    // app Version
    static func getAppVersionInfo() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    // Build number
    static func getAppBuildNumberInfo() -> String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    //  OS name
    static func getOSName() -> String {
        return UIDevice.current.systemName
    }
    //  OS version
    static func getOSVersion() -> String {
        return UIDevice.current.systemVersion
    }
    // ID for Vender.
    static func getVenderID() -> String {
       let venderId = UIDevice.current.identifierForVendor
        return String(describing: venderId)
    }
    // ID for Ad.
    static func getAdvertisingID() -> String {
        let advertisingId = ASIdentifierManager().advertisingIdentifier
        return String(describing: advertisingId)
    }
    
    static func getSelectedCity() ->String? {
        let app = UIApplication.shared.delegate as! AppDelegate
        let city = app.appUserDefaultManager.getSelectedCity()
        return city
    }
    
    // check the version change
    static func isAppVersionChanged() ->Bool {
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
<<<<<<< Updated upstream
        #if DEBUG
        return true // for debug
        #else
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.appUserDefaultManager.getUserAgreement()
        #endif
=======
#if debug_mode
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.appUserDefaultManager.getUserAgreement()
#else
        return true // for debug
#endif
>>>>>>> Stashed changes
    }
    /*
    static func isUserSignined() ->Bool {
<<<<<<< Updated upstream
        #if DEBUG
        return true // for debug
        #else
=======
#if debug_mode
>>>>>>> Stashed changes
        let app = UIApplication.shared.delegate as! AppDelegate
        let currentUser = app.appUserDefaultManager.getCurrentUser()
        if (currentUser == nil) || (currentUser == "") {
            return false
        } else {
            return true
        }
<<<<<<< Updated upstream
        #endif
    }*/
    // get login status
    class func isUserLogin() -> Bool {
        #if DEBUG
        return true // for debug
        #else
        //let app = UIApplication.shared.delegate as! AppDelegate
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
        //let app = UIApplication.shared.delegate as! AppDelegate
        return app.appUserDefaultManager.getUserLock()
        #endif
=======
#else
        return true // for debug
#endif
    }
    static func isUserLocked() ->Bool {
#if debug_mode
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.appUserDefaultManager.getUserLock()
#else
        return false // for debug
#endif
>>>>>>> Stashed changes
    }
}

extension UIViewController {
    public func getVersionInfo() {
        self.getVersionInfo()
    }
    public func getBuildNumberInfo() {
        self.getBuildNumberInfo()
    }
    
    //MARK: - ========== extension ==========
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}
