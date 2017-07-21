//
//  Extension+UIBarButtonItem.swift
//  MoneyBook
//
//  Created by HONGQUAN on 7/21/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import Foundation
import CoreGraphics

extension UIBarButtonItem {
    convenience init(imageName: String, highlImageName: String, target: AnyObject, action: Selector) {
    
        let button: UIButton = UIButton(type: .custom)
        
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setImage(UIImage(named: highlImageName), for: .highlighted)
        button.frame = CGRect.CGRectMake(0,0,50,44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        button.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView: button)
    }
    
    convenience init(imageName: String, highlImageName: String, selectedImage: String, target: AnyObject, action: Selector) {
        
        let button: UIButton = UIButton(type: .custom)
        
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setImage(UIImage(named: highlImageName), for: .highlighted)
        button.frame = CGRect.CGRectMake(0,0,50,44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        button.setImage(UIImage(named: selectedImage), for: .selected)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        button.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView: button)
    }
    /// 针对导航条左边按钮的自定义item
    convenience init(leftimageName: String, highlImageName: String, targer: AnyObject, action: Selector) {
        let button: UIButton = UIButton(type: .custom)
        button.setImage(UIImage(named: leftimageName), for: .normal)
        button.setImage(UIImage(named: highlImageName), for: .highlighted)
        button.frame = CGRect.CGRectMake(0, 0, 80, 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        button.addTarget(targer, action: action, for: .touchUpInside)
        
        self.init(customView: button)
    }

    /// 导航条纯文字按钮
    convenience init(title: String, titleClocr: UIColor, targer: AnyObject ,action: Selector) {
        
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleClocr, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12) //theme.SDNavItemFont
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.frame = CGRect.CGRectMake(0, 0, 80, 44)
        button.titleLabel?.textAlignment = NSTextAlignment.right
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5)
        button.addTarget(targer, action: action, for: .touchUpInside)
        
        self.init(customView: button)
    }

}

