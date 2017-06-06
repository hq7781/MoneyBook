//
//  Extension+UIColor.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/01.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    static func enixExtraLightGray(alpha: CGFloat = 1) -> UIColor {
        return UIColor(white: 0.94, alpha: alpha) // 240
    }
    
    static func enixOrange(alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: 229 / 255, green: 127 / 255, blue: 71 / 255, alpha: alpha)
    }
    
    static func enixGreen(alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: 61 / 255, green: 255 / 255, blue: 43 / 255, alpha: alpha)
    }
}
