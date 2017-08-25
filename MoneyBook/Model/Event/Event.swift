//
//  Event.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/03.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

// expenses  Event 支出 spending
// income  Event 収入
import Foundation

/// Represents a event.
class Event: NSObject {
    
    /// Invalid event identifier.
    static let EventIdNone = 0

    /// Identifier.
    private(set) var eventId: Int
    
    /// Event Type. / Expend / Income
    private(set) var eventType: Bool
    /// Event Category.Income: / salary /annuity / rent / other ...
    /// Event Category.Expend: / fashion /rent / eat / social / traffic cost / medical fee / insurance / tax
    private(set) var eventCategory: String
    /// Event SubCategory.
    private(set) var eventSubCategory: String
    /// Event AccountType. cash / deposit ／ card / otherPay
    private(set) var eventAccountType: String
    /// Event memo.
    private(set) var eventMemo: String
    /// Event Payment.
    private(set) var eventPayment: Int64
    /// Payment Currency.
    private(set) var currencyType: String
    /// User name
    private(set) var userName: String
    /// Release date.
    private(set) var recodedDate: Date
    /// Updated date.
    private(set) var modifiedDate: Date

    /// Initialize the instance.
    ///
    /// - Parameters:
    ///   - eventId:       Identifier
    ///   - userName:      UserName.
    ///   - eventMemo:     Event memo.

    ///   - eventCategory: Event category
    ///   - eventSubCategory: Event Sub Category
    ///   - recodedDate:   First recoded Date
    ///   - modifiedDate:  ModifiedDate Date
    init(eventId: Int,
         eventType: Bool,
         eventCategory: String,
         eventSubCategory: String,
         eventAccountType: String,
         eventMemo: String,
         eventPayment: Int64,
         currencyType: String,
         userName: String,
         recodedDate: Date,
         modifiedDate: Date) {
        self.eventId        = eventId
        self.eventType      = eventType
        self.eventCategory  = eventCategory
        self.eventSubCategory = eventSubCategory
        self.eventAccountType = eventAccountType
        self.eventMemo      = eventMemo
        self.eventPayment   = eventPayment
        self.currencyType   = currencyType
        self.userName       = userName
        self.recodedDate    = recodedDate
        self.modifiedDate   = modifiedDate
    }
}

