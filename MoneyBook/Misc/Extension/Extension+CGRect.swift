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
}
