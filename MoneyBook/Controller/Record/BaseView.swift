//
//  BaseView.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/01.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit

class BaseView: UIView {

    var name : String!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //MARK: - ========== override Init methods ==========
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(self.someAction(_ :)))
        self.addGestureRecognizer(gesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(self.someAction(_:)))
        self.addGestureRecognizer(gesture)
        //fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ========== ViewController methods ==========
    func someAction(_ sender: UIGestureRecognizer){
        print(self.name)
        if ((self.name) == nil) {
            print( "self.name is nil")
            return
        }
        switch self.name {
        case D_calVC_name:
            let secondViewController = self.parentViewController?.storyboard?.instantiateViewController(withIdentifier: self.name) as! CalculatorViewController
            secondViewController.delegate = self.parentViewController as! RecordsViewControllerDelegate?
            self.parentViewController?.navigationController?.pushViewController(secondViewController, animated: true)
        case D_spentVC_name:
            let secondViewController = self.parentViewController?.storyboard?.instantiateViewController(withIdentifier: self.name) as! SpentViewController
            secondViewController.delegate = self.parentViewController as! RecordsViewControllerDelegate?
            self.parentViewController?.navigationController?.pushViewController(secondViewController, animated: true)
        case D_statusVC_name:
            let secondViewController = self.parentViewController?.storyboard?.instantiateViewController(withIdentifier: self.name) as! StatusViewController
            secondViewController.delegate = self.parentViewController as! RecordsViewControllerDelegate?
            self.parentViewController?.navigationController?.pushViewController(secondViewController, animated: true)
        case D_fromAccVC_name:
            let secondViewController = self.parentViewController?.storyboard?.instantiateViewController(withIdentifier: self.name) as! AccountViewController
            secondViewController.delegate = self.parentViewController as! RecordsViewControllerDelegate?
            self.parentViewController?.navigationController?.pushViewController(secondViewController, animated: true)
        default:
            print("error: %@",self.name)
            //fatalError("self.name has not been implemented")
        }

    }
}

//MARK: - ========== extension UIView ==========
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        //fatalError("self.name has not been implemented")
        return nil
    }
}
