//
//  ContentType.swift
//  MoneyBook
//
//  Created by HongQuan on 6/5/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import UIKit

enum ContentType: String, CustomStringConvertible {
    
    case expend = "content_music.png"
    case income = "content_films.png"
    
    func next() -> ContentType {
        switch self {
        case .expend:
            return .income
        case .income:
            return .expend
        }
    }
    
    var image: UIImage {
        let image =  UIImage(named: rawValue)!
        return image
    }
    
    var description: String {
        switch self {
        case .expend:
            return "Expend"
        case .income:
            return "Income"
        }
    }
}
