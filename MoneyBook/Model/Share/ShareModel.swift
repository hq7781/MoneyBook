//
//  ShareModel.swift
//  MoneyBook
//
//  Created by HONG QUAN on 7/18/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import UIKit

class ShareModel: NSObject {

    var shareTitle:  String?
    var shareURL:    String?
    var shareImage:  UIImage?
    var shareDetail: String?
    
    init(shareTitle: String?, shareURL: String?,
         shareImage: UIImage?, shareDetail: String?) {
        super.init()
        
        if shareDetail != nil {
            if let text: NSString = NSString(cString: shareDetail!.cString(using: String.Encoding.utf8)!,encoding: String.Encoding.utf8.rawValue) {
                if text.length > 50 {
                    let tmp = text.substring(to: 50)
                    self.shareDetail = tmp as String
                } else {
                    self.shareDetail = shareDetail
                }
            }
        }
        self.shareTitle = shareTitle
        self.shareImage = shareImage
        self.shareURL = shareURL
    }
}
