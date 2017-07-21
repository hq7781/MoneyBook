//
//  Extension+CGRect.swift
//  MoneyBook
//
//  Created by HongQuan on 6/5/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGRect {
    
    init(boundingCenter center: CGPoint, radius: CGFloat) {
        assert(0 <= radius, "radius must be a positive value")
        
        self = CGRect(origin: center, size: .zero).insetBy(dx: -radius, dy: -radius)
    }

    //MARK: - ========== extension ==========
    static func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    static func CGPointMake(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    static func CGSizeMake(_ width: CGFloat, _ height: CGFloat) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    static func CGRectZero() ->CGRect {
        return CGRect.zero
    }
    static func CGPointZero() -> CGPoint {
        return CGPoint.zero
    }
}
