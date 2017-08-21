//
//  AppUtils.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/17.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//
import UIKit
import Foundation
import AdSupport
import GoogleMobileAds

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
        return app.appUserDefaultManager.getSelectedCity()
    }
    
    static func getVisitCount() ->Int? {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.appUserDefaultManager.getVisitCount()
    }
    static func setVisiCount() ->Bool {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.appUserDefaultManager.setVisitCount()
    }
    
    // check the version change
    static func isAppVersionChanged() ->Bool {
        #if DEBUG
        return false // for debug
        #else
        let cureentVersion = getAppVersionInfo()
        let app = UIApplication.shared.delegate as! AppDelegate
        let oldVersion = app.appUserDefaultManager.getCurrentVerion()
        if oldVersion == nil {
            return true
        }
        return (cureentVersion.compare(oldVersion!) != ComparisonResult.orderedDescending)
        #endif
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
    }
    static func isHiddenAdvert() ->Bool {
        #if DEBUG
            return false // for debug
        #else
            //let app = UIApplication.shared.delegate as! AppDelegate
            return app.appUserDefaultManager.getAdvertFlag()
        #endif
    }
    
    static func googleTracking(_ screenName : String?) {
        //https://analytics.google.com/
        let tracker = GAI.sharedInstance().defaultTracker
        tracker?.set(kGAIScreenName, value: screenName)
        
        let builder = GAIDictionaryBuilder.createScreenView()
        tracker?.send(builder?.build() as [NSObject : AnyObject]!)
    }
    
    static func googleTracking(_ category : String?,
                               _ action : String?,
                               _ label : String?,
                               _ value : Int?) {
        let tracker = GAI.sharedInstance().defaultTracker
        tracker?.set(kGAIEventValue, value: action)
        
        let builder = GAIDictionaryBuilder.createEvent(withCategory: category,
                                                            action: action,
                                                            label: label,
                                                            value: value! as NSNumber)
        tracker?.send(builder?.build() as [NSObject : AnyObject]!)
    }
}

extension UIViewController : GADBannerViewDelegate {

    public func showAdBannerView() {
        if AppUtils.isHiddenAdvert() {
            return
        }
        let bannerView: GADBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannerView.delegate = self
        bannerView.rootViewController = self
        bannerView.adUnitID = kGooGleFirebaseAdMobAdvertUnitID
        
        let gadRequst : GADRequest = GADRequest()
        gadRequst.testDevices = [kGADSimulatorID]
        bannerView.load(gadRequst as GADRequest?)
        bannerView.frame = CGRectMake(0, view.bounds.height - bannerView.frame.size.height,
                                      bannerView.frame.size.width, bannerView.frame.size.height)
        
        self.view.addSubview(bannerView)
    }
    
    // delegate methods
    public func adViewDidReceiveAd(_ bannerView: GADBannerView) {
    }

    public func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
    }
    // to display full screen
    public func adViewWillPresentScreen(_ bannerView: GADBannerView) {}

    public func adViewWillDismissScreen(_ bannerView: GADBannerView) {}

    public func adViewDidDismissScreen(_ bannerView: GADBannerView) {}

    public func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
    // clicked an adview
        print("clicked an adview")
        AppUtils.googleTracking("AdMobClick", bannerView.adUnitID,
                                 NSStringFromClass(type(of:self) as! AnyClass),0)
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
