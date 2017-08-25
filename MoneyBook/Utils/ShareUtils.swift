//
//  ShareUtils.swift
//  MoneyBook
//
//  Created by HONG QUAN on 7/18/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import UIKit

class Shareutils: NSObject {
    // SINA
    class func shareToSina (model: ShareModel, viewController: UIViewController?) {
        /*
        let image: UIImage = UIImage(named:"userName")!
        UMSocialControllerService.defaultControllerService().setShareText(model.shareDetail! +
            theme.JianshuURL, shareImage: image, socialUIDelete: nil)
        UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToSina).snsClickHandler
        (viewController, UMSocialControllerService.defaultControllerService(), true)
 */
    }
    
    // WECHAT
    class func shareToWeChat(model: ShareModel) {
        /*
        UMSocialData.defaultData().extConfig.wechatSessionData.url = theme.JianShuURL
        UMSocialData.defaultData().extConfig.wechatSessionData.title = model.shareTitle
        
        let image: UIImage = UIImage(named: "userName")!
        let shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: model.shareURL)
        
        UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatSession], content: model.shareDetail, image: image, location: nil, urlResource: shareURL, presentedController: nil) { (response) -> Void in
            if response.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                SVProgressHUD.showSuccessWithStatus("分享成功")
            }
        }
 */
    }
    
    class func shareToWeChatFriends(model: ShareModel) {
        /*
        UMSocialData.defaultData().extConfig.wechatSessionData.url = theme.JianShuURL
        UMSocialData.defaultData().extConfig.wechatSessionData.title = model.shareTitle
        
        let image: UIImage = UIImage(named: "userName")!
        let shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: model.shareURL)
        
        UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatTimeline], content: model.shareTitle, image: image, location: nil, urlResource: shareURL, presentedController: nil) { (response) -> Void in
            if response.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                SVProgressHUD.showSuccessWithStatus("分享成功")
            }
        }*/
    }
    
}
