//
//  MainNavigationController.swift
//  MoneyBook
//
//  Created by HONGQUAN on 7/25/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer!.delegate = nil
    }
    
    lazy var backButton: UIButton = {
        let backButton = UIButton(type: UIButtonType.custom)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        backButton.setTitleColor(UIColor.black, for: .normal)
        backButton.setTitleColor(UIColor.gray, for: .highlighted)
        backButton.setImage(UIImage(named:"back_1"), for: .normal)
        backButton.setImage(UIImage(named:"back_2"), for: .highlighted)
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0)
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        let btnWeight: CGFloat = appWidth > 375.0 ? 50 : 44
        backButton.frame = CGRect.CGRectMake(0, 0, btnWeight, 40)
        
        backButton.addTarget(self, action: #selector(onClickBackButton), for: .touchUpInside)
        return backButton
        
    }()
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            let vc = self.childViewControllers[0]
            
            if self.childViewControllers.count == 1 {
                backButton.setTitle(vc.tabBarItem.title, for: UIControlState.normal)
            } else {
                backButton.setTitle("BACK", for: UIControlState.normal)
            }
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView:backButton)
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func onClickBackButton() {
        self.popViewController(animated: true)
    }

}
