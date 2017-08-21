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
let kUIStoryboardName_Setting      = "Setting"

// ViewController Identifier 常量
let kUIViewControllerId_Agreement     = "Agreement"
let kUIViewControllerId_Signin        = "Signin"
let kUIViewControllerId_TouchToUnlock = "TouchToUnlock"

let kUIViewControllerId_MainTabBarVC = "MainTabBarVC"
let kUIViewControllerId_NewRecordsVC = "NewRecordsVC"

let kUIViewControllerId_AboutVC      = "AboutVC"

// 通知名称常量
let kNotificationNameAgreementViewWillShow = NSNotification.Name(rawValue:"NotificationNameAgreementViewWillShow")
let kNotificationNameAgreementViewWillHide = NSNotification.Name(rawValue:"NotificationNameAgreementViewWillHide")

let kNotificationNameUserAuthencationStart = NSNotification.Name(rawValue:"NotificationNameUserAuthencationStart")
let kNotificationNameUserAuthencationStop  = NSNotification.Name(rawValue:"NotificationNameUserAuthencationStop")
let kNotificationNameUserAuthencationSuccessed = NSNotification.Name(rawValue:"NotificationNameUserAuthencationSuccessed")
let kNotificationNameUserAuthencationFailed  = NSNotification.Name(rawValue:"NotificationNameUserAuthencationFailed")

let kNotificationUserInfoKey_UserTryLimit = "UserTryLimit"
let kNotificationUserInfoKey_ErrorMessage = "ErrorMessage"

let kNotificationNameCurrentCityhasChanged = NSNotification.Name(rawValue:"NotificationNameCurrentCityhasChanged")


// User Default Key 名称常量
let kUserDefaultKey_versionStr  = "CFBundleShortVersionString"
let kUserDefaultKey_VisitCount  = "VisitCount"
let kUserDefaultKey_Agreement   = "AgreementFlag"
let kUserDefaultKey_CurrentUser = "CurrentUser"
let kUserDefaultKey_UserLock    = "UserLockFlag"
let kUserDefaultKey_AdvertFlag  = "AdvertFlag"
let kUserDefaultKey_Account     = "UserAccount"
let kUserDefaultKey_Password    = "UserPassword"
let kUserDefaultKey_SelectedCity = "SelectedCity"
// chache path
let kAppImageCachePath = "com.enixsoft.imagecache"

let kTryUserAuthenticateMaxCount = 5

// for SNS Share
let appShareViewHeight: CGFloat = 215
let GithubURL: String = ""
let UMSharedApiKey: String = ""

// for Firebase AdMob application ID
let kGooGleFirebaseAdMobApplicationID = "ca-app-pub-3940256099942544~1458002511"
// for Firebase AdMob Advertising Uinit ID
let kGooGleFirebaseAdMobAdvertUnitID = "ca-app-pub-3940256099942544~1458002511"
