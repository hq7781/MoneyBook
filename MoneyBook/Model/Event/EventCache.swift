//
//  EventCache.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/03.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import Foundation

/// Manager fot the event data.
class EventCache: NSObject {
    /// A collection of user names.
    var userList = Array<String>()
    
    /// Dictionary of book collection classified by userName.
    var eventsByUser = Dictionary<String, Array<Event>>()
    
    /// Initialize the instance.
    override init() {
        super.init()
    }
    
    /// Initialize the instance.
    ///
    /// - Parameter events: Collection of the event data.
    init(events: Array<Event>) {
        super.init()
        
        events.forEach({ (event) in
            if !self.add(event: event) {
                print("Faild to add event: " + event.userName + " - " + event.eventMemo )
            }
        })
    }
    
    /// Add the new event.
    ///
    /// - Parameter event: Event data.
    /// - Returns: "true" if successful.
    func add(event: Event) -> Bool {
        if event.eventId == Event.EventIdNone {
            return false
        }
        
        if var existEvents = self.eventsByUser[event.userName] {
            existEvents.append(event)
            self.eventsByUser.updateValue(existEvents, forKey: event.userName)
        } else {
            var newEvents = Array<Event>()
            newEvents.append(event)
            self.eventsByUser[event.userName] = newEvents
            self.userList.append(event.userName)
        }
        
        return true
    }
    
    /// Remove the event.
    ///
    /// - Parameter event: Event data.
    /// - Returns: "true" if successful.
    func remove(event: Event) -> Bool {
        guard var events = self.eventsByUser[event.userName] else {
            return false
        }
        
        for i in 0..<events.count {
            let existEvent = events[i]
            if existEvent.eventId == event.eventId {
                events.remove(at: i)
                self.eventsByUser.updateValue(events, forKey: event.userName)
                break
            }
        }
        
        if events.count == 0 {
            return self.removeUser(userName: event.userName)
        }
        
        return true
    }
    
    /// Update the event.
    ///
    /// - Parameter oldEvent: New event data.
    /// - Parameter newEvent: Old event data.
    /// - Returns: "true" if successful.
    func update(oldEvent: Event, newEvent: Event) -> Bool {
        if oldEvent.userName == newEvent.userName {
            return self.replaceEvent(newEvent: newEvent)
        } else if self.remove(event: oldEvent) {
            return self.add(event: newEvent)
        }
        
        return false
    }
    
    /// Remove the userName at the inner collection.
    ///
    /// - Parameter userName: Name of the user.
    /// - Returns: "true" if successful.
    private func removeUser(userName: String) -> Bool {
        self.eventsByUser.removeValue(forKey: userName)
        for i in 0..<self.userList.count {
            let existUser = self.userList[i]
            if existUser == userName {
                self.userList.remove(at: i)
                return true
            }
        }
        
        return false
    }
    
    /// Replace the event.
    ///
    /// - Parameter newEvent: New event data.
    /// - Returns: "true" if successful.
    private func replaceEvent(newEvent: Event) -> Bool {
        guard var events = self.eventsByUser[newEvent.userName] else {
            return false
        }
        
        for i in 0..<events.count {
            let event = events[i]
            if event.eventId == newEvent.eventId {
                events[i] = newEvent
                self.eventsByUser.updateValue(events, forKey: newEvent.userName)
                return true
            }
        }
        
        return false
    }
}
