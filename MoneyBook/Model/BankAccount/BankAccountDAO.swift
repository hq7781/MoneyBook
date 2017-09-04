//
//  BankAccountDAO.swift
//  MoneyBook
//
//  Created by HONGQUAN on 8/29/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import Foundation
import FMDB

class BankAccountDAO: NSObject {

    //MARK: - ==========  var define ==========
    /// Query for the create table.
    private static let SQLCreate = "" +
        "CREATE TABLE IF NOT EXISTS bankaccounts (" +
        "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
        "bankActive INTEGER" +
        "bankName TEXT" +
        "branchName TEXT" +
        "bankCode TEXT" +
        "BranceCode TEXT" +
        "accountName TEXT" +
        "accountNumber TEXT" +
        "accountType TEXT, " +
        "savings INTEGER, " +
        "currencyType TEXT, " +
        "updatedDate INTEGER, " +
    ");"
    
    /// Query for the select row.
    private static let SQLSelect = "" +
        "SELECT " +
        "id, bankActive, bankName, branchName, bankCode, BranceCode, accountName, accountNumber, accountType, savings, currencyType, updatedDate " +
        "FROM " +
        "bankaccounts;" +
        "ORDER BY " +
        "bankName, accountNumber;"
    
    /// Query for the inssert row.
    private static let SQLInsert = "" +
        "INSERT INTO " +
        "bankaccounts (bankActive, bankName, branchName, bankCode, BranceCode, accountName, accountNumber, accountType, savings, currencyType, updatedDate) " +
        "VALUES " +
    "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
    
    /// Query for the update row.
    private static let SQLUpdate = "" +
        "UPDATE " +
        "bankaccounts " +
        "SET " +
        "bankActive = ?, bankName = ?, branchName = ?, bankCode = ?, BranceCode = ?, accountName = ?, accountNumber = ?, accountType = ?, savings = ?, currencyType = ?, updatedDate = ?" +
        "WHERE " +
    "id = ?;"
    
    /// Query for the delete row.
    private static let SQLDelete = "DELETE FROM bankaccounts WHERE id = ?;"
    
    /// Instance of the database connection.
    private let db: FMDatabase
    
    
    //MARK: - ========== override Init methods ==========
    /// Initialize the instance.
    ///
    /// - Parameter db: Instance of the database connection.
    init(db: FMDatabase) {
        self.db = db
        super.init()
    }
    
    deinit {
        self.db.close()
    }
    
    //MARK: - ========== Sqlite opreation methods ==========
    /// Create the table.
    func create() {
        self.db.executeUpdate(BankAccountDAO.SQLCreate, withArgumentsIn: [])
    }
    
    /// Add the Bank Account.
    ///
    /// - Parameters:
    ///   - userName:    UserName.
    ///   - eventMemo:   Event Memo.
    ///   - recodedDate: First recoded date.
    /// - Returns: Added the BankAccount.

    func add(bankActive: Bool, bankName: String, branchName: String,
             bankCode: String, branceCode: String, accountName: String,
             accountNumber: String, accountType: String,
             savings: Int64, currencyType: String, updatedDate: Date) -> BankAccount? {
        var bankAccount: BankAccount? = nil
        if self.db.executeUpdate(BankAccountDAO.SQLInsert, withArgumentsIn: [
            bankActive, bankName, branchName, bankCode, branceCode, accountName, accountNumber, accountType, savings, currencyType, updatedDate,]) {
            let bankAccountId = db.lastInsertRowId
            
            bankAccount = BankAccount(bankAccountId:  Int(bankAccountId),
                          bankActive:   bankActive,
                          bankName:     bankName,
                          branchName:   branchName,
                          //bankCode:     bankCode,
                          //branceCode:   branceCode,
                          accountName:  accountName,
                          accountNumber:accountNumber,
                          accountType:  accountType,
                          savings:      savings,
                          currencyType: currencyType,
                          updatedDate:  updatedDate)
        }
        return bankAccount
    }
    
    /// Read a bankAccounts.
    ///
    /// - Returns: Readed bankAccounts.
    
    func read() -> Array<BankAccount> {
        var bankaccounts = Array<BankAccount>()
        if let results = self.db.executeQuery(BankAccountDAO.SQLSelect, withArgumentsIn: []) {
            while results.next() {
                let bankaccount = BankAccount(bankAccountId: results.long(forColumnIndex: 0),
                                  bankActive:   results.bool(forColumnIndex:1),
                                  bankName:     results.string(forColumnIndex: 2)!,
                                  branchName:   results.string(forColumnIndex: 3)!,
                                  //bankCode:     results.string(forColumnIndex: 4)!,
                                  //branceCode:   results.string(forColumnIndex: 5)!,
                                  accountName:  results.string(forColumnIndex: 6)!,
                                  accountNumber:results.string(forColumnIndex: 7)!,
                                  accountType:  results.string(forColumnIndex: 8)!,
                                  savings:      results.longLongInt(forColumnIndex: 9),
                                  currencyType: results.string(forColumnIndex: 10)!,
                                  updatedDate:  results.date(forColumnIndex: 11)!)
                
                bankaccounts.append(bankaccount)
            }
        }
        return bankaccounts
    }
    
    /// Remove a bankaccounts.
    ///
    /// - Parameter eventId: The identifier of the event to remove.
    /// - Returns: "true" if successful.
    func remove(bankAccountId: Int) -> Bool {
        return self.db.executeUpdate(BankAccountDAO.SQLDelete, withArgumentsIn: [bankAccountId])
    }
    
    /// Update a bankaccounts.
    ///
    /// - Parameter event: The data of the event to update.
    /// - Returns: "true" if successful.
    func update(bankaccount: BankAccount) -> Bool {
        
        return db.executeUpdate(BankAccountDAO.SQLUpdate,
                                withArgumentsIn: [
                                    bankaccount.bankActive,
                                    bankaccount.bankName,
                                    bankaccount.branchName,
                                    bankaccount.bankCode,
                                    bankaccount.branceCode,
                                    bankaccount.accountName,
                                    bankaccount.accountNumber,
                                    bankaccount.accountType,
                                    bankaccount.savings,
                                    bankaccount.currencyType,
                                    bankaccount.updatedDate,
                                    bankaccount.bankAccountId])
    }
}
