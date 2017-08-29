//
//  BankAccount.swift
//  MoneyBook
//
//  Created by HONGQUAN on 8/25/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import Foundation
// expenses 存款和取款 deposit & drawing
// income  saving

/// Represents a event.
class BankAccount: NSObject {
    
    /// Invalid event identifier.
    static let BankAccountIdNone = 0
    
    /// Identifier.
    private(set) var bankAccountId: Int
    
    /// Event Type. / Expend / Income
    private(set) var bankActive: Bool
    ///
    private(set) var bankName: String
    ///
    private(set) var branchName: String
    ///
    private(set) var bankCode: String
    /// Event memo.
    private(set) var branceCode: String
    /// User name
    private(set) var accountName: String
    /// Account Number
    private(set) var accountNumber: String
    /// Account Type
    private(set) var accountType: String
    ///
    private(set) var savings: Int64
    /// Payment Currency.
    private(set) var currencyType: String
    /// Updated date.
    private(set) var updatedDate: Date
    
    /// Initialize the instance.
    ///
    /// - Parameters:
    ///   - bankAccountId:  Identifier
    ///   - bankName:       UserName.
    ///   - branchName:     Event memo.
    ///   - accountNumber:  Int64
    ///   - accountType:    Event category
    ///   - savings:        Event Sub Category
    ///   - currencyType:
    ///   - updatedDate:    Updated Date

    init(bankAccountId: Int,
         bankActive:    Bool,
         bankName:      String,
         branchName:    String,
         accountName:   String,
         accountNumber: String,
         accountType:   String,
         savings:       Int64,
         currencyType:  String,
         updatedDate:   Date) {
        self.bankAccountId  = bankAccountId
        self.bankActive     = bankActive
        self.bankName       = bankName
        self.bankCode       = ""
        self.branchName     = branchName
        self.branceCode     = ""
        self.accountName    = accountName
        self.accountNumber  = accountNumber
        self.accountType    = accountType
        self.savings        = savings
        self.currencyType   = currencyType
        self.updatedDate    = updatedDate
    }
}
