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
        let app = UIApplication.shared.delegate as! AppDelegate
        //return app.appUserDefaultManager.getUserAgreement()
        return true // for debug
    }
    static func isUserSignined() ->Bool {
        let app = UIApplication.shared.delegate as! AppDelegate
        let currentUser = app.appUserDefaultManager.getCurrentUser()
        //if (currentUser == nil) || (currentUser == "") {
        //    return false
        //} else {
        //    return true
        //}
        return true // for debug
    }
    static func isUserLocked() ->Bool {
        let app = UIApplication.shared.delegate as! AppDelegate
        //return app.appUserDefaultManager.getUserLock()
        return false // for debug
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
