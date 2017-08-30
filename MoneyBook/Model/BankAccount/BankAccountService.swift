//
//  BankAccountService.swift
//  MoneyBook
//
//  Created by HONGQUAN on 8/30/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import Foundation

/// Manage for the bankAccounts.
class BankAccountService: NSObject {
  
    /// Factory of a data access objects.
    private let daoFactory: DAOFactory
    
    /// Initialize the instance.
    ///
    /// - Parameter daoFactory: Factory of a data access objects.
    init(daoFactory: DAOFactory) {
        self.daoFactory = daoFactory
        super.init()
        
        if let dao = self.daoFactory.bankaccountDAO() {
            dao.create()
            //self.eventCache = EventCache(events: dao.read())
        }
    }
    
    /// Add the new bank account.
    ///
    /// - Parameter bankaccount: bank account data.
    /// - Returns: "true" if successful.
    func add(bankaccount: BankAccount) -> Bool {
        if let dao = self.daoFactory.bankaccountDAO(),
            (dao.add(bankActive: bankaccount.bankActive,
                     bankName: bankaccount.bankName,
                     branchName: bankaccount.branchName,
                     bankCode: bankaccount.bankCode,
                     branceCode: bankaccount.branceCode,
                     accountName: bankaccount.accountName,
                     accountNumber: bankaccount.accountNumber,
                     accountType: bankaccount.accountType,
                     savings: bankaccount.savings,
                     currencyType: bankaccount.currencyType,
                     updatedDate: bankaccount.updatedDate) != nil) {

            return true
        }
        return false
    }
    
    /// Remove the bank account.
    ///
    /// - Parameter bankaccount: Account data.
    /// - Returns: "true" if successful.
    func remove(bankaccount: BankAccount) -> Bool {
        if let dao = self.daoFactory.bankaccountDAO(), dao.remove(bankAccountId: bankaccount.bankAccountId) {
            return true
        }
        return false
    }
    
    /// Update the bankaccount.
    ///
    /// - Parameter oldBankaccount: Old bankaccount data.
    /// - Parameter new account: New account data.
    /// - Returns: "true" if successful.
    func update(oldBankaccount: BankAccount, NewBankaccount: BankAccount) -> Bool {
        if let dao = self.daoFactory.bankaccountDAO(), dao.update(bankaccount: NewBankaccount) {
            return true
        }
        return false
    }
}
