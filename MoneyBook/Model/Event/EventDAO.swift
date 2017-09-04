//
//  EventDAO.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/03.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit
import FMDB

class EventDAO: NSObject {
    //MARK: - ==========  var define ==========
    /// Query for the create table.
    private static let SQLCreate = "" +
        "CREATE TABLE IF NOT EXISTS events (" +
        "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
        "eventType INTEGER" +
        "eventCategory TEXT" +
        "eventSubCategory TEXT" +
        "eventAccountType TEXT" +
        "eventMemo TEXT" +
        "eventPayment TEXT" +
        "currencyType TEXT" +
        "userName TEXT, " +
        "recodedDate INTEGER, " +
        "modifiedDate INTEGER, " +
    ");"
    
    /// Query for the select row.
    private static let SQLSelect = "" +
        "SELECT " +
        "id, eventType, eventCategory, eventSubCategory, eventAccountType, eventMemo, eventPayment, currencyType, userName, recodedDate, modifiedDate " +
        "FROM " +
        "events;" +
        "ORDER BY " +
    "userName, eventMemo;"
    
    /// Query for the inssert row.
    private static let SQLInsert = "" +
        "INSERT INTO " +
        "events (eventType, eventCategory, eventSubCategory, eventAccountType, eventMemo, eventPayment, currencyType, userName, recodedDate, modifiedDate) " +
        "VALUES " +
    "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"

    /// Query for the update row.
    private static let SQLUpdate = "" +
        "UPDATE " +
        "events " +
        "SET " +
        "eventType = ?, eventCategory = ?, eventSubCategory = ?, eventAccountType = ?, eventMemo = ?, eventPayment = ?, currencyType = ?, userName = ?, recodedDate = ?, modifiedDate = ?" +
        "WHERE " +
    "id = ?;"

    
    /// Query for the delete row.
    private static let SQLDelete = "DELETE FROM events WHERE id = ?;"
    
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
        self.db.executeUpdate(EventDAO.SQLCreate, withArgumentsIn: [])
    }
    
    /// Add the Event.
    ///
    /// - Parameters:
    ///   - userName:    UserName.
    ///   - eventMemo:   Event Memo.
    ///   - recodedDate: First recoded date.
    /// - Returns: Added the event.
    func add(eventType: Bool, eventCategory: String, eventSubCategory: String,
             eventAccountType: String, eventMemo: String, eventPayment: Int64,
             currencyType: String, userName: String,
             recodedDate: Date, modifiedDate: Date) -> Event? {
        var event: Event? = nil
        if self.db.executeUpdate(EventDAO.SQLInsert, withArgumentsIn: [
            eventType, eventCategory, eventSubCategory, eventAccountType, eventMemo, eventPayment, currencyType, userName, recodedDate, modifiedDate,
            ]) {
            let eventId = db.lastInsertRowId
            
            event = Event(eventId:          Int(eventId),
                          eventType:        eventType,
                          eventCategory:    eventCategory,
                          eventSubCategory: eventSubCategory,
                          eventAccountType: eventAccountType,
                          eventMemo:        eventMemo,
                          eventPayment:     eventPayment,
                          currencyType:     currencyType,
                          userName:         userName,
                          recodedDate:      recodedDate,
                          modifiedDate:     modifiedDate)
        }
        return event
    }
    
    /// Read a events.
    ///
    /// - Returns: Readed events.
    func read() -> Array<Event> {
        var events = Array<Event>()
        if let results = self.db.executeQuery(EventDAO.SQLSelect, withArgumentsIn: []) {
            while results.next() {
                let event = Event(eventId:          results.long(forColumnIndex: 0),
                                  eventType:        results.bool(forColumnIndex:1),
                                  eventCategory:    results.string(forColumnIndex: 2)!,
                                  eventSubCategory: results.string(forColumnIndex: 3)!,
                                  eventAccountType: results.string(forColumnIndex: 4)!,
                                  eventMemo:        results.string(forColumnIndex: 5)!,
                                  eventPayment:     results.longLongInt(forColumnIndex: 6),
                                  currencyType:     results.string(forColumnIndex: 7)!,
                                  userName:         results.string(forColumnIndex: 8)!,
                                  recodedDate:      results.date(forColumnIndex: 9)!,
                                  modifiedDate:     results.date(forColumnIndex: 10)!)
                
                events.append(event)
            }
        }
        return events
    }
    
    /// Remove a event.
    ///
    /// - Parameter eventId: The identifier of the event to remove.
    /// - Returns: "true" if successful.
    func remove(eventId: Int) -> Bool {
        return self.db.executeUpdate(EventDAO.SQLDelete, withArgumentsIn: [eventId])
    }
    
    /// Update a event.
    ///
    /// - Parameter event: The data of the event to update.
    /// - Returns: "true" if successful.
    func update(event: Event) -> Bool {
        return db.executeUpdate(EventDAO.SQLUpdate,
                                withArgumentsIn: [
                                    event.eventType,
                                    event.eventCategory,
                                    event.eventSubCategory,
                                    event.eventAccountType,
                                    event.eventMemo,
                                    event.eventPayment,
                                    event.currencyType,
                                    event.userName,
                                    event.recodedDate,
                                    event.modifiedDate,
                                    event.eventId])
    }
}
