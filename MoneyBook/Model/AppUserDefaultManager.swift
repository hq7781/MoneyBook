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
        return userDefault.synchronize()
    }
    func getCurrentVerion()-> String? {
        let currentVersion:String? = userDefault.string(forKey: kUserDefaultKey_versionStr)
        return currentVersion
    }
    ///
    func setVisitCount()-> Bool {
        let appVisitCount:Int = userDefault.integer(forKey: kUserDefaultKey_VisitCount)
        userDefault.set((appVisitCount + 1),forKey: kUserDefaultKey_VisitCount)
        return userDefault.synchronize()
    }
    func getVisitCount()-> Int {
        let appVisitCount:Int = userDefault.integer(forKey: kUserDefaultKey_VisitCount)
        return appVisitCount
    }
    ///
    func setCurrentUser(currentUser:String?)-> Bool {
        userDefault.set(currentUser,forKey:kUserDefaultKey_CurrentUser)
        return userDefault.synchronize()
    }
    func getCurrentUser()-> String? {
        let currentUser:String? = userDefault.string(forKey: kUserDefaultKey_CurrentUser)
        return currentUser
    }
    ///
    func setUserAccount(account:String?)-> Bool {
        userDefault.set(account,forKey:kUserDefaultKey_Account)
        return userDefault.synchronize()
    }
    func getUserAccount()-> String? {
        let account:String? = userDefault.string(forKey: kUserDefaultKey_Account)
        return account
    }
    ///
    func setUserPassword(password:String?)-> Bool {
        userDefault.set(password,forKey:kUserDefaultKey_Password)
        return userDefault.synchronize()
    }
    func getUserPassword()-> String? {
        let password:String? = userDefault.string(forKey: kUserDefaultKey_Password)
        return password
    }
    func setSelectedCity(city:String?)-> Bool {
        userDefault.set(city,forKey:kUserDefaultKey_SelectedCity)
        return userDefault.synchronize()
    }
    func getSelectedCity()-> String? {
        let selectedCity = userDefault.string(forKey: kUserDefaultKey_SelectedCity)
        return selectedCity
    }
    ///
    func setUserAgreement(ON:Bool)-> Bool {
        userDefault.set(ON,forKey:kUserDefaultKey_Agreement)
        return userDefault.synchronize()
    }
    func getUserAgreement()-> Bool {
        let userAgree:Bool = userDefault.bool(forKey: kUserDefaultKey_Agreement)
        return userAgree
    }
    ///
    func setUserLock(ON:Bool)-> Bool {
        userDefault.set(ON,forKey:kUserDefaultKey_UserLock)
        return userDefault.synchronize()
    }
    func getUserLock()-> Bool {
        let userLock:Bool = userDefault.bool(forKey: kUserDefaultKey_UserLock)
        return userLock
    }
    func setAdvertFlag(ON:Bool)-> Bool {
        // if ON then disable the Advert view
        userDefault.set(ON,forKey:kUserDefaultKey_AdvertFlag)
        return userDefault.synchronize()
    }
    func getAdvertFlag() -> Bool {
        let advertFlag:Bool = userDefault.bool(forKey: kUserDefaultKey_AdvertFlag)
        return advertFlag
    }
    ///
    func resetUserDefault()-> Bool {
        userDefault.set(nil,   forKey:kUserDefaultKey_versionStr)
        userDefault.set(0,     forKey:kUserDefaultKey_VisitCount)
        userDefault.set(nil,   forKey:kUserDefaultKey_CurrentUser)
        userDefault.set(false, forKey:kUserDefaultKey_Agreement)
        userDefault.set(false, forKey:kUserDefaultKey_UserLock)
        return userDefault.synchronize()
    }

}
