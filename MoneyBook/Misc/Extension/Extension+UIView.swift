//
//  Extension+UIView.swift
//  MoneyBook
//
//  Created by HONGQUAN on 7/24/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import Foundation

extension UIView {
    var x: CGFloat {
        return self.frame.origin.x
    }
    var y: CGFloat {
        return self.frame.origin.y
    }
    var width: CGFloat {
        return self.frame.size.width
    }
    var height: CGFloat {
        return self.frame.size.height
    }
    
    var size: CGSize {
        return self.frame.size
    }
    var point: CGPoint {
        return self.frame.origin
    }
}
