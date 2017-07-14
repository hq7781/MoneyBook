//
//  AppUserDefaultManager.swift
//  MoneyBook
//
//  Created by HongQuan on 5/30/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import Foundation


/// Manage for the application UserDefault Setting Values.
class AppUserDefaultManager: NSObject {
    /// Manager fot the application UserDefault data. Info.plist
    private var appUserDefault:UserDefaults!
    
    /// Initialize the instance.
    override init() {
        super.init()
        self.appUserDefault = UserDefaults()
    }
    ///
    func setCurrentVersion(currentVersion:String?)-> Bool {
        appUserDefault.set(currentVersion,forKey:kUserDefaultKey_versionStr)
        appUserDefault.synchronize()
        return true
    }
    func getCurrentVerion()-> String? {
        let currentVersion:String? = appUserDefault.string(forKey: kUserDefaultKey_versionStr)
        return currentVersion
    }
    ///
    func setVisitCount()-> Bool {
        let appVisitCount:Int = appUserDefault.integer(forKey: kUserDefaultKey_VisitCount)
        appUserDefault.set((appVisitCount + 1),forKey: kUserDefaultKey_VisitCount)
        appUserDefault.synchronize()
        return true
    }
    func getVisitCount()-> Int {
        let appVisitCount:Int = appUserDefault.integer(forKey: kUserDefaultKey_VisitCount)
        return appVisitCount
    }
    ///
    func setCurrentUser(currentUser:String?)-> Bool {
        appUserDefault.set(currentUser,forKey:kUserDefaultKey_CurrentUser)
        appUserDefault.synchronize()
        return true
    }
    func getCurrentUser()-> String? {
        let currentUser:String? = appUserDefault.string(forKey: kUserDefaultKey_CurrentUser)
        return currentUser
    }
    ///
    func setUserAgreement(ON:Bool)-> Bool {
        appUserDefault.set(ON,forKey:kUserDefaultKey_Agreement)
        appUserDefault.synchronize()
        return true
    }
    func getUserAgreement()-> Bool {
        let userAgree:Bool = appUserDefault.bool(forKey: kUserDefaultKey_Agreement)
        return userAgree
    }
    ///
    func setUserLock(ON:Bool)-> Bool {
        appUserDefault.set(ON,forKey:kUserDefaultKey_UserLock)
        appUserDefault.synchronize()
        return true
    }
    func getUserLock()-> Bool {
        let userLock:Bool = appUserDefault.bool(forKey: kUserDefaultKey_UserLock)
        return userLock
    }
    ///
    func resetUserDefault()-> Bool {
        appUserDefault.set(nil,   forKey:kUserDefaultKey_versionStr)
        appUserDefault.set(0,     forKey:kUserDefaultKey_VisitCount)
        appUserDefault.set(nil,   forKey:kUserDefaultKey_CurrentUser)
        appUserDefault.set(false, forKey:kUserDefaultKey_Agreement)
        appUserDefault.set(false, forKey:kUserDefaultKey_UserLock)
        appUserDefault.synchronize()
        return true
    }

}
