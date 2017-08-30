//
//  EventService.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/03.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import Foundation

/// Manage for the events.
class EventService: NSObject {
    /// Collection of userNames.
    var userList: Array<String> {
        get {
            return self.eventCache.userList
        }
    }
    
    /// Dictionary of event collection classified by userName.
    var eventsByUser: Dictionary<String, Array<Event>> {
        get {
            return self.eventCache.eventsByUser
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
    /// - Parameter event: event data.
    /// - Returns: "true" if successful.
    func add(event: Event) -> Bool {
        if let dao = self.daoFactory.eventDAO(),
            let newEvent = dao.add(eventType: event.eventType,
                                   eventCategory: event.eventCategory,
                                   eventSubCategory: event.eventSubCategory,
                                   eventAccountType: event.eventAccountType,
                                   eventMemo: event.eventMemo,
                                   eventPayment: event.eventPayment,
                                   currencyType: event.currencyType,
                                   userName: event.userName,
                                   recodedDate: event.recodedDate,
                                   modifiedDate: event.modifiedDate) {
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
