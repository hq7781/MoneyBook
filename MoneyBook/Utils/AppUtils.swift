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
    
    func getAppVersionInfo() -> String {
        // Versionを取得.
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        return version
    }
    func getAppBuildNumberInfo() -> String {
        // Build番号を取得.
        let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
        return build
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
