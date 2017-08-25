//
//  BankAccount.swift
//  MoneyBook
//
//  Created by HONGQUAN on 8/25/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import Foundation
// expenses  Event 支出 存款和取款    deposit & drawing
// income  saving 収入

/// Represents a event.
class BankAccount: NSObject {
    
    /// Invalid event identifier.
    static let BankAccountIdNone = 0
    
    /// Identifier.
    private(set) var bankAccountId: Int
    
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
        self.bankAccountId  = eventId
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
