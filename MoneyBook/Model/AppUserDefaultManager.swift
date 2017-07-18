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
    private var userDefault: UserDefaults!
    
    /// Initialize the instance.
    override init() {
        super.init()
        self.userDefault = UserDefaults()
    }
    ///
    func setCurrentVersion(currentVersion:String?)-> Bool {
        userDefault.set(currentVersion,forKey:kUserDefaultKey_versionStr)
        userDefault.synchronize()
        return true
    }
    func getCurrentVerion()-> String? {
        let currentVersion:String? = userDefault.string(forKey: kUserDefaultKey_versionStr)
        return currentVersion
    }
    ///
    func setVisitCount()-> Bool {
        let appVisitCount:Int = userDefault.integer(forKey: kUserDefaultKey_VisitCount)
        userDefault.set((appVisitCount + 1),forKey: kUserDefaultKey_VisitCount)
        userDefault.synchronize()
        return true
    }
    func getVisitCount()-> Int {
        let appVisitCount:Int = userDefault.integer(forKey: kUserDefaultKey_VisitCount)
        return appVisitCount
    }
    ///
    func setCurrentUser(currentUser:String?)-> Bool {
        userDefault.set(currentUser,forKey:kUserDefaultKey_CurrentUser)
        userDefault.synchronize()
        return true
    }
    func getCurrentUser()-> String? {
        let currentUser:String? = userDefault.string(forKey: kUserDefaultKey_CurrentUser)
        return currentUser
    }
    ///
    func setUserAccount(account:String?)-> Bool {
        userDefault.set(account,forKey:kUserDefaultKey_Account)
        userDefault.synchronize()
        return true
    }
    func getUserAccount()-> String? {
        let account:String? = userDefault.string(forKey: kUserDefaultKey_Account)
        return account
    }
    ///
    func setUserPassword(password:String?)-> Bool {
        userDefault.set(password,forKey:kUserDefaultKey_Password)
        userDefault.synchronize()
        return true
    }
    func getUserPassword()-> String? {
        let password:String? = userDefault.string(forKey: kUserDefaultKey_Password)
        return password
    }
    ///
    func setUserAgreement(ON:Bool)-> Bool {
        userDefault.set(ON,forKey:kUserDefaultKey_Agreement)
        userDefault.synchronize()
        return true
    }
    func getUserAgreement()-> Bool {
        let userAgree:Bool = userDefault.bool(forKey: kUserDefaultKey_Agreement)
        return userAgree
    }
    ///
    func setUserLock(ON:Bool)-> Bool {
        userDefault.set(ON,forKey:kUserDefaultKey_UserLock)
        userDefault.synchronize()
        return true
    }
    func getUserLock()-> Bool {
        let userLock:Bool = userDefault.bool(forKey: kUserDefaultKey_UserLock)
        return userLock
    }
    ///
    func resetUserDefault()-> Bool {
        userDefault.set(nil,   forKey:kUserDefaultKey_versionStr)
        userDefault.set(0,     forKey:kUserDefaultKey_VisitCount)
        userDefault.set(nil,   forKey:kUserDefaultKey_CurrentUser)
        userDefault.set(false, forKey:kUserDefaultKey_Agreement)
        userDefault.set(false, forKey:kUserDefaultKey_UserLock)
        userDefault.synchronize()
        return true
    }

}
