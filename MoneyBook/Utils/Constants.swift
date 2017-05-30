//
//  Constants.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/01.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import Foundation

// StoryBoard 名称常量
let kUIStoryboardName_Main         = "Main"
let kUIStoryboardName_LaunchScreen = "LaunchScreen"
let kUIStoryboardName_Startup      = "Startup"

// ViewController Identifier 常量
let kUIViewControllerId_Agreement     = "Agreement"
let kUIViewControllerId_Signin        = "Signin"
let kUIViewControllerId_TouchToUnlock = "TouchToUnlock"

let kUIViewControllerId_MainTabBarVC = "MainTabBarVC"
let kUIViewControllerId_NewRecordsVC = "NewRecordsVC"

// 通知名称常量
let kNotificationNameAgreementViewWillShow = NSNotification.Name(rawValue:"NotificationNameAgreementViewWillShow")
let kNotificationNameAgreementViewWillHide = NSNotification.Name(rawValue:"NotificationNameAgreementViewWillHide")

// User Default Key 名称常量
let kUserDefaultKey_VisitCount  = "VisitCount"
let kUserDefaultKey_Agreement   = "AgreementFlag"
let kUserDefaultKey_CurrentUser = "CurrentUser"
let kUserDefaultKey_UserLock    = "UserLockFlag"
