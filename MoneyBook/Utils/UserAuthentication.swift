//
//  UserAuthentication.swift
//  MoneyBook
//
//  Created by HONGQUAN on 5/31/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import Foundation
import LocalAuthentication

// Result type (authentication result)
public enum AuthenticationResult {
    // from system or user action
    case authenticationSuccessed
    case authenticationFailed
    case authenticationUserCanceled
    case authenticationUserFallback
    case authenticationSystemCanceled
    case authenticationPasscodeNotSet
    case authenticationTouchIDNotAvailable
    case authenticationTouchIDNotEnrolled
    // from customized event
    case authenticationUserTryLimited
    case authenticationUserTimeOver
    // Unkonwn error
    case authenticationUnknownError
}

@available(iOS 8.0, *)
class UserAuthentication: NSObject {
    private var context:LAContext!
    private var tryCount:Int!
    /// Initialize the instance.
    override init() {
        super.init()
        self.tryCount = kTryUserAuthenticateMaxCount

        NotificationCenter.default.addObserver(self, selector: #selector(OnUserAuthencationStart),
                                               name: kNotificationNameUserAuthencationStart, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(OnUserAuthencationStop),
                                               name: kNotificationNameUserAuthencationStop, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func OnUserAuthencationStart(notification: NSNotification) {
        let userInfo = notification.userInfo
        if (userInfo?[kNotificationUserInfoKey_UserTryLimit] as? String) != nil {
            let count = userInfo?[kNotificationUserInfoKey_UserTryLimit] as! String
            self.tryCount = Int(count)!
        }
        if canAuthenticateByTouchId() {
            authenticateByTouchId()
        } else {
            authenticateByPasscode()
        }
    }
    
    func OnUserAuthencationStop(notification: NSNotification) {
    }

    func actionWithAuthenticationSuccessed() {
        NotificationCenter.default.post(name:kNotificationNameUserAuthencationSuccessed, object: nil, userInfo: nil)
    }
    func actionWithAuthenticationFailed() {
        if self.tryCount == 0 {
            actionWithAuthenticationUserTryLimited()
            return
        }
        tryCount = tryCount - 1
        let userInfo = [kNotificationUserInfoKey_ErrorMessage : "検証失敗、検証可能回数\(tryCount)"]
        NotificationCenter.default.post(name:kNotificationNameUserAuthencationFailed, object: nil, userInfo: userInfo )

    }
    func actionWithAuthenticationUserCanceled() {
        let userInfo = [kNotificationUserInfoKey_ErrorMessage : "ユーザから検証を取り消しました"]
        NotificationCenter.default.post(name:kNotificationNameUserAuthencationFailed, object: nil, userInfo: userInfo )
    }

    func actionWithTouchIdAuthenticationUserFallback() {
        self.authenticateByPasscode()
    }
    func actionWithAuthenticationSystemCanceled() {
        let userInfo = [kNotificationUserInfoKey_ErrorMessage : "システムから検証を取消されました"]
        NotificationCenter.default.post(name:kNotificationNameUserAuthencationFailed, object: nil, userInfo: userInfo )
    }
    func actionWithAuthenticationPasscodeNotSet() {
        let userInfo = [kNotificationUserInfoKey_ErrorMessage : "Passcode Not Set"]
        NotificationCenter.default.post(name:kNotificationNameUserAuthencationFailed, object: nil, userInfo: userInfo )
    }
    func actionWithAuthenticationTouchIdNotAvailable() {
        let userInfo = [kNotificationUserInfoKey_ErrorMessage : "Touch Id Not Available"]
        NotificationCenter.default.post(name:kNotificationNameUserAuthencationFailed, object: nil, userInfo: userInfo )
    }
    func actionWithAuthenticationTouchIDNotEnrolled() {
        let userInfo = [kNotificationUserInfoKey_ErrorMessage : "Touch Id Not Enrolled"]
        NotificationCenter.default.post(name:kNotificationNameUserAuthencationFailed, object: nil, userInfo: userInfo )
    }
    func actionWithAuthenticationUnknownError() {
        let userInfo = [kNotificationUserInfoKey_ErrorMessage : "不明エラー"]
        NotificationCenter.default.post(name:kNotificationNameUserAuthencationFailed, object: nil, userInfo: userInfo )
    }
    func actionWithAuthenticationUserTryLimited() {
        let userInfo = [kNotificationUserInfoKey_ErrorMessage : "検証可能回数制限"]
        NotificationCenter.default.post(name:kNotificationNameUserAuthencationFailed, object: nil, userInfo: userInfo )
    }

    func authenticateByTouchId() {
        let policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
        
        LAContext().evaluatePolicy(policy,
                                   localizedReason: "このアプリの利用には認証が必要です",
                                   reply: {
                                    (success: Bool, error: Error?) -> Void in
                                    guard success else {
                                        print("Touch ID Auth result: %@", error.debugDescription)
                                        let nserror = error as? NSError
                                        switch nserror!._code {
                                        case LAError.authenticationFailed.rawValue:
                                            self.actionWithAuthenticationFailed()
                                        case LAError.userCancel.rawValue:
                                            self.actionWithAuthenticationUserCanceled()
                                        case LAError.userFallback.rawValue:
                                            self.actionWithTouchIdAuthenticationUserFallback()
                                        case LAError.systemCancel.rawValue:
                                            self.actionWithAuthenticationSystemCanceled()
                                        case LAError.passcodeNotSet.rawValue:
                                            self.actionWithAuthenticationPasscodeNotSet()
                                        case LAError.touchIDNotAvailable.rawValue:
                                            self.actionWithAuthenticationTouchIdNotAvailable()
                                        case LAError.touchIDNotEnrolled.rawValue:
                                            self.actionWithAuthenticationTouchIDNotEnrolled()
                                        default:
                                            self.actionWithAuthenticationUnknownError()
                                            break
                                        }
                                        return
                                    }
                                    self.actionWithAuthenticationSuccessed()
        })
    }
    
    func authenticateByPasscode() {
        let policy = LAPolicy.deviceOwnerAuthentication
        LAContext().evaluatePolicy(policy,
                                   localizedReason: "パスコードを入力してください",
                                   reply: {
                                    (success: Bool, error: Error?) -> Void in
                                    guard success else {
                                        print("Passcode Auth result: %@", error.debugDescription)
                                        let nserror = error as? NSError
                                        switch nserror!._code {
                                        case LAError.authenticationFailed.rawValue:
                                            self.actionWithAuthenticationFailed()
                                        case LAError.userCancel.rawValue:
                                            self.actionWithAuthenticationUserCanceled()
                                        case LAError.userFallback.rawValue:
                                            self.actionWithTouchIdAuthenticationUserFallback()
                                        case LAError.systemCancel.rawValue:
                                            self.actionWithAuthenticationFailed()
                                        case LAError.passcodeNotSet.rawValue:
                                            self.actionWithAuthenticationFailed()
                                        case LAError.touchIDNotAvailable.rawValue:
                                            self.actionWithAuthenticationFailed()
                                        case LAError.touchIDNotEnrolled.rawValue:
                                            self.actionWithAuthenticationFailed()
                                        default:
                                            self.actionWithAuthenticationUnknownError()
                                            break
                                        }
                                        return
                                    }
                                    self.actionWithAuthenticationSuccessed()
                                    
        })
    }
    
    func canAuthenticateByTouchId() -> Bool {
        // Touch ID API が利用できるかをチェック
        var authError: NSError?
        let policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics

        guard LAContext().canEvaluatePolicy(policy, error: &authError) else {
                let nserror = authError
                print("Touch ID support check result: \(nserror?.localizedDescription)")
                switch nserror!._code {
                case LAError.authenticationFailed.rawValue:
                    print("Touch ID support check result: kLAErrorAuthenticationFailed")
                case LAError.userCancel.rawValue:
                    print("Touch ID support check result: kLAErrorUserCancel")
                case LAError.userFallback.rawValue:
                    print("Touch ID support check result: kLAErrorUserFallback")
                case LAError.systemCancel.rawValue:
                    print("Touch ID support check result: kLAErrorSystemCancel")
                case LAError.passcodeNotSet.rawValue:
                    print("Touch ID support check result: kLAErrorPasscodeNotSet")
                case LAError.touchIDNotAvailable.rawValue:
                    print("Touch ID support check result: kLAErrorTouchIDNotAvailable")
                case LAError.touchIDNotEnrolled.rawValue:
                    print("Touch ID support check result: kLAErrorTouchIDNotEnrolled")
                default: break
                }
                return false
            }
        return true
    }
}
