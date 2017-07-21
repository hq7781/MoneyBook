//
//  UserAccountUtils.swift
//  MoneyBook
//
//  Created by recomot on 7/18/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import Foundation

class UserAccountUtils: NSObject {
    // if in login  then get user account info
    class func userAccount() -> String? {
        if !AppUtils.isUserLogin() {
            return nil
        }
        let app = UIApplication.shared.delegate as! AppDelegate
        let account = app.appUserDefaultManager.getUserAccount()
        return account
    }
}
