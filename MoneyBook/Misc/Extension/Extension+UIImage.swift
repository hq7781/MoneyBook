//
//  Extension+UIImage.swift
//  MoneyBook
//
//  Created by HONGQUAN on 7/21/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import Foundation
import CoreGraphics

extension UIImage {
    // resize image
    class func imageClipToNewImage(image: UIImage, newSize:CGSize) ->UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(origin: CGPoint.zero, size:newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    // add clip
    class func imageWithClipImage(image: UIImage, borderWidth: CGFloat, borderColor: UIColor) -> UIImage {
        let imageWH = image.size.width
        let ovalWH = imageWH + 2 * borderWidth
        
        UIGraphicsBeginImageContextWithOptions(CGRect.CGSizeMake(ovalWH, ovalWH), false, 0.0)
        let path = UIBezierPath(ovalIn: CGRect.CGRectMake(0, 0, ovalWH, ovalWH))
        borderColor.set()
        path.fill()
        
        let clipPath = UIBezierPath(ovalIn:CGRect.CGRectMake(borderWidth, borderWidth, imageWH, imageWH))
        clipPath.addClip()
        image.draw(at: CGRect.CGPointMake(borderWidth, borderWidth))
        
        let clipImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return clipImage!
    }
    // draw to clrcle image
    func imageClipOvalImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        let rect = CGRect.CGRectMake(0, 0, self.size.width, self.size.height)
        ctx!.addEllipse(in: rect)
        ctx!.clip()
        self.draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
}
