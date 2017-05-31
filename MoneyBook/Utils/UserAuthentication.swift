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
        self.context = LAContext()
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
        }
        if canAuthenticateByTouchId() {
            let result = authenticateByTouchId()
            switch result {
            case .authenticationSuccessed:
                NotificationCenter.default.post(name:kNotificationNameUserAuthencationSuccessed, object: nil, userInfo: nil)
                break
            case .authenticationFailed:
                if self.tryCount > 0 {
                    tryCount = tryCount - 1
                    let userInfo = [kNotificationUserInfoKey_ErrorMessage : "検証失敗、検証可能回数\(tryCount)"]
                    NotificationCenter.default.post(name:kNotificationNameUserAuthencationFailed, object: nil, userInfo: userInfo )
                }
            case .authenticationUserCanceled:
                let userInfo = [kNotificationUserInfoKey_ErrorMessage : "検証を取り消しました"]
                NotificationCenter.default.post(name:kNotificationNameUserAuthencationFailed, object: nil, userInfo: userInfo )
            case .authenticationUserTryLimited:
                let userInfo = [kNotificationUserInfoKey_ErrorMessage : "検証の回数多すぎです"]
                NotificationCenter.default.post(name:kNotificationNameUserAuthencationFailed, object: nil, userInfo: userInfo )
            case .authenticationUserFallback:
                let result = self.authenticateByPasscode()
                switch result {
                case .authenticationSuccessed:
                    NotificationCenter.default.post(name:kNotificationNameUserAuthencationSuccessed, object: nil, userInfo: nil)
                case .authenticationUserCanceled, .authenticationUserFallback, .authenticationUserTryLimited:
                    let userInfo = [kNotificationUserInfoKey_ErrorMessage : "検証に失敗しました"]
                    NotificationCenter.default.post(name:kNotificationNameUserAuthencationFailed, object: nil, userInfo: userInfo )
                default:
                    break
                }
            default:
                break
            }
        } else {
            let result = authenticateByPasscode()
            switch result {
            case .authenticationSuccessed:
                NotificationCenter.default.post(name:kNotificationNameUserAuthencationSuccessed, object: nil, userInfo: nil)
                break
            case .authenticationUserCanceled, .authenticationUserFallback, .authenticationUserTryLimited:
                break
            default:
                break
            }
            
        }
    }
    
    func OnUserAuthencationStop(notification: NSNotification) {
    }

    func authenticateByTouchId() -> AuthenticationResult {
        var result = .authenticationUnknownError as AuthenticationResult
        let policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
        DispatchQueue.main.async {
            self.context.evaluatePolicy(policy,
                                   localizedReason: "このアプリの利用には認証が必要です",
                                   reply: {
                                    (success: Bool, error: Error?) -> Void in
                                    //self.updateMySecurityLabel(success)
                                    print("Touch ID Auth result: %@", error.debugDescription)
                                    guard success else {
                                        let nserror = error as? NSError
                                        switch nserror!._code {
                                        case LAError.authenticationFailed.rawValue: //kLAErrorAuthenticationFailed:
                                            print("Touch ID Auth result: kSecUseAuthenticationUIFail")
                                            result = .authenticationFailed
                                        case LAError.userCancel.rawValue: //kLAErrorUserCancel:
                                            print("Touch ID Auth result: kLAErrorUserCancel")
                                            result = .authenticationUserCanceled
                                        case LAError.userFallback.rawValue: //kLAErrorUserFallback:
                                            print("Touch ID Auth result: kLAErrorUserFallback")
                                            //result = self.authenticateByPasscode()
                                            result = .authenticationUserFallback
                                        case LAError.systemCancel.rawValue: //kLAErrorSystemCancel:
                                            print("Touch ID Auth result: kLAErrorSystemCancel")
                                            result = .authenticationSystemCanceled
                                        case LAError.passcodeNotSet.rawValue: //kLAErrorPasscodeNotSet:
                                            print("Touch ID Auth result: kLAErrorPasscodeNotSet")
                                            result = .authenticationPasscodeNotSet
                                        case LAError.touchIDNotAvailable.rawValue:// kLAErrorTouchIDNotAvailable:
                                            print("Touch ID Auth result: kLAErrorTouchIDNotAvailable")
                                        case LAError.touchIDNotEnrolled.rawValue: //kLAErrorTouchIDNotEnrolled:
                                            result = .authenticationTouchIDNotEnrolled
                                            print("Touch ID Auth result: kLAErrorTouchIDNotEnrolled")
                                        default:
                                            result = .authenticationUnknownError
                                            break
                                        }
                                        return
                                    }
                                    result = .authenticationSuccessed
            })
        }
        return result
    }
    
    func authenticateByPasscode() -> AuthenticationResult {
        var result = .authenticationUnknownError as AuthenticationResult
        let policy = LAPolicy.deviceOwnerAuthentication
        DispatchQueue.main.async {
            self.context.evaluatePolicy(policy,
                                   localizedReason: "パスコードを入力してください",
                                   reply: {
                                    (success: Bool, error: Error?) -> Void in
                                    //self.updateMySecurityLabel(success)
                                    print("Passcode Auth result: %@", error.debugDescription)
                                    guard success else {
                                        let nserror = error as? NSError
                                        switch nserror!._code {
                                        case LAError.authenticationFailed.rawValue:
                                            result = .authenticationFailed
                                        case LAError.userCancel.rawValue:
                                            result = .authenticationUserCanceled
                                        case LAError.userFallback.rawValue:
                                            //result = self.authenticateByPasscode()
                                            result = .authenticationUserFallback
                                        case LAError.systemCancel.rawValue:
                                            result = .authenticationSystemCanceled
                                        case LAError.passcodeNotSet.rawValue:
                                            result = .authenticationPasscodeNotSet
                                        case LAError.touchIDNotAvailable.rawValue:
                                            result = .authenticationTouchIDNotAvailable
                                        case LAError.touchIDNotEnrolled.rawValue:
                                            result = .authenticationTouchIDNotEnrolled
                                        default:
                                            result = .authenticationUnknownError
                                            break
                                        }
                                        return
                                    }
                                    result = .authenticationSuccessed

            })
        }
        return result
    }
    
    func canAuthenticateByTouchId() -> Bool {
        // Touch ID API が利用できるかをチェック
        var result = true as Bool
        var authError: NSError?
        let policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
        DispatchQueue.main.async {
            guard self.context.canEvaluatePolicy(policy, error: &authError) else {
                let nserror = authError
                switch nserror!._code {
                case LAError.authenticationFailed.rawValue:
                    print("Touch ID Auth result: kLAErrorAuthenticationFailed")
                case LAError.userCancel.rawValue:
                    print("Touch ID Auth result: kLAErrorUserCancel")
                case LAError.userFallback.rawValue:
                    print("Touch ID Auth result: kLAErrorUserFallback")
                case LAError.systemCancel.rawValue:
                    print("Touch ID Auth result: kLAErrorSystemCancel")
                case LAError.passcodeNotSet.rawValue:
                    print("Touch ID Auth result: kLAErrorPasscodeNotSet")
                case LAError.touchIDNotAvailable.rawValue:
                    print("Touch ID Auth result: kLAErrorTouchIDNotAvailable")
                case LAError.touchIDNotEnrolled.rawValue:
                    print("Touch ID Auth result: kLAErrorTouchIDNotEnrolled")
                default: break
                }
                print("Touch ID support check result: \(nserror?.localizedDescription)")
                result = false
                return
            }
        }
        return result
    }
}
