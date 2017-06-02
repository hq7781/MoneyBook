//
//  Event.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/03.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

// outgo  Event 支出 spending
// income  Event 収入
import UIKit

/// Represents a event.
class Event: NSObject {
    /// Invalid event identifier.
    static let EventIdNone = 0
    /// Identifier.
    private(set) var eventId: Int
    /// Title.
    private(set) var title: String
    /// Author.
    private(set) var author: String
    /// Release date.
    private(set) var releaseDate: Date
    /// Updated date.
    private(set) var updatedDate: Date
    /// Event Type.
    private(set) var eventType: Bool
    /// Event Category.
    private(set) var eventCategory: String
    /// Event SubCategory.
    private(set) var eventSubCategory: String
    /// Event AccountType.
    private(set) var eventAccountType: String
    /// Event Payment.
    private(set) var eventPayment: Int64
    /// Payment Currency.
    private(set) var currencyType: String
    
    /// Initialize the instance.
    ///
    /// - Parameters:
    ///   - eventId:     Identifier
    ///   - author:      Author.
    ///   - title:       Title.
    ///   - releaseDate:   Release Date
    ///   - updatedDate:   Updated Date
    ///   - eventCategory: Event category Date
    init(eventId: Int, author: String, title: String, releaseDate: Date, updatedDate: Date, eventCategory: String) {
        self.eventId     = eventId
        self.author      = author
        self.title       = title
        self.releaseDate = releaseDate
        self.updatedDate = updatedDate
        self.eventType      = true
        self.eventCategory  = eventCategory
        self.eventSubCategory = ""
        self.eventAccountType = ""
        self.eventPayment   = 0
        self.currencyType   = ""
    }
}

