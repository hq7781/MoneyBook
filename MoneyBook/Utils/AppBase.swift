//
//  AppBase.swift
//  MoneyBook
//
//  Created by HONGQUAN on 7/24/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import UIKit
// public UI parameters
public let appWidth: CGFloat = UIScreen.main.bounds.size.width
public let appHeight: CGFloat = UIScreen.main.bounds.size.height
public let mainBounds: CGRect = UIScreen.main.bounds
    
public let appShare = UIApplication.shared
//public let appDelegate = appShare.delegate as! AppDelegate
public let appCachesPath =
        NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last

struct theme {
    static let appNaviItemFont = UIFont.systemFont(ofSize:16)
    static let appNaviTitleFont = UIFont.systemFont(ofSize:18)
    static let appBackgroundColor = UIColor.enixColorWith(red: 255, green: 255, blue: 255, alpha: 1)
    static let appWebViewBackgrounderColor = UIColor.enixColorWith(red: 245, green: 245, blue: 245, alpha: 1)
    
    //
}
