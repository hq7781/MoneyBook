//
//  EventService.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/03.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit

/// Manage for the events.
class EventService: NSObject {
    /// Collection of author names.
    var authors: Array<String> {
        get {
            return self.eventCache.authors
        }
    }
    
    /// Dictionary of event collection classified by author name.
    var eventsByAuthor: Dictionary<String, Array<Event>> {
        get {
            return self.eventCache.eventsByAuthor
        }
    }
    
    /// Factory of a data access objects.
    private let daoFactory: DAOFactory
    
    /// Manager for the event data.
    private var eventCache: EventCache!
    
    /// Initialize the instance.
    ///
    /// - Parameter daoFactory: Factory of a data access objects.
    init(daoFactory: DAOFactory) {
        self.daoFactory = daoFactory
        super.init()
        
        if let dao = self.daoFactory.eventDAO() {
            dao.create()
            self.eventCache = EventCache(events: dao.read())
        }
    }
    
    /// Add the new event.
    ///
    /// - Parameter book: Book data.
    /// - Returns: "true" if successful.
    func add(event: Event) -> Bool {
        if let dao = self.daoFactory.eventDAO(), let newEvent = dao.add(author: event.author, title: event.title, releaseDate: event.releaseDate, updatedDate:event.updatedDate, eventCategory: event.eventCategory) {
            return self.eventCache.add(event: newEvent)
        }
        
        return false
    }
    
    /// Remove the event.
    ///
    /// - Parameter event: Event data.
    /// - Returns: "true" if successful.
    func remove(event: Event) -> Bool {
        if let dao = self.daoFactory.eventDAO(), dao.remove(eventId: event.eventId) {
            return self.eventCache.remove(event: event)
        }
        
        return false
    }
    
    /// Update the event.
    ///
    /// - Parameter oldEvent: New event data.
    /// - Parameter newBook: Old book data.
    /// - Returns: "true" if successful.
    func update(oldEvent: Event, newEvent: Event) -> Bool {
        if let dao = self.daoFactory.eventDAO(), dao.update(event: newEvent) {
            return self.eventCache.update(oldEvent: oldEvent, newEvent: newEvent)
        }
        
        return false
    }
}
