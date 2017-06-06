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
        "author TEXT, " +
        "title TEXT, " +
        "release_date INTEGER, " +
        "updated_date INTEGER, " +
        "category TEXT" +
    ");"
    
    /// Query for the inssert row.
    private static let SQLSelect = "" +
        "SELECT " +
        "id, author, title, release_date, updated_date, category " +
        "FROM " +
        "events;" +
        "ORDER BY " +
    "author, title;"
    
    /// Query for the inssert row.
    private static let SQLInsert = "" +
        "INSERT INTO " +
        "events (author, title, release_date, updated_date, category) " +
        "VALUES " +
    "(?, ?, ?, ?, ?);"
    
    /// Query for the update row.
    private static let SQLUpdate = "" +
        "UPDATE " +
        "events " +
        "SET " +
        "author = ?, title = ?, release_date = ?, updated_date = ?, category = ? " +
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
        self.db.executeUpdate(EventDAO.SQLCreate, withArgumentsIn: nil)
    }
    
    /// Add the Event.
    ///
    /// - Parameters:
    ///   - author:      Author.
    ///   - title:       Title.
    ///   - releaseDate: Release date.
    /// - Returns: Added the event.
    func add(author: String, title: String, releaseDate: Date, updatedDate: Date, eventCategory: String) -> Event? {
        var event: Event? = nil
        if self.db.executeUpdate(EventDAO.SQLInsert, withArgumentsIn: [author, title, releaseDate, updatedDate, eventCategory]) {
            let eventId = db.lastInsertRowId()
            event = Event(eventId:      Int(eventId),
                          author:       author,
                          title:        title,
                          releaseDate:  releaseDate,
                          updatedDate:  updatedDate,
                          eventCategory:eventCategory)
        }
        
        return event
    }
    
    /// Read a events.
    ///
    /// - Returns: Readed events.
    func read() -> Array<Event> {
        var events = Array<Event>()
        if let results = self.db.executeQuery(EventDAO.SQLSelect, withArgumentsIn: nil) {
            while results.next() {
                let event = Event(eventId:      results.long(forColumnIndex: 0),
                                  author:       results.string(forColumnIndex: 1),
                                  title:        results.string(forColumnIndex: 2),
                                  releaseDate:  results.date(forColumnIndex: 3),
                                  updatedDate:  results.date(forColumnIndex: 4),
                                  eventCategory:results.string(forColumnIndex: 5)
                )
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
                                    event.author,
                                    event.title,
                                    event.releaseDate,
                                    event.updatedDate,
                                    event.eventCategory,
                                    event.eventId])
    }
}
