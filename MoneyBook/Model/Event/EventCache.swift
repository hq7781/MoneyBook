//
//  EventCache.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/03.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit

/// Manager fot the event data.
class EventCache: NSObject {
    /// A collection of author names.
    var authors = Array<String>()
    
    /// Dictionary of book collection classified by author name.
    var eventsByAuthor = Dictionary<String, Array<Event>>()
    
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
                print("Faild to add event: " + event.author + " - " + event.title )
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
        
        if var existEvents = self.eventsByAuthor[event.author] {
            existEvents.append(event)
            self.eventsByAuthor.updateValue(existEvents, forKey: event.author)
        } else {
            var newEvents = Array<Event>()
            newEvents.append(event)
            self.eventsByAuthor[event.author] = newEvents
            self.authors.append(event.author)
        }
        
        return true
    }
    
    /// Remove the event.
    ///
    /// - Parameter event: Event data.
    /// - Returns: "true" if successful.
    func remove(event: Event) -> Bool {
        guard var events = self.eventsByAuthor[event.author] else {
            return false
        }
        
        for i in 0..<events.count {
            let existEvent = events[i]
            if existEvent.eventId == event.eventId {
                events.remove(at: i)
                self.eventsByAuthor.updateValue(events, forKey: event.author)
                break
            }
        }
        
        if events.count == 0 {
            return self.removeAuthor(author: event.author)
        }
        
        return true
    }
    
    /// Update the event.
    ///
    /// - Parameter oldEvent: New event data.
    /// - Parameter newEvent: Old event data.
    /// - Returns: "true" if successful.
    func update(oldEvent: Event, newEvent: Event) -> Bool {
        if oldEvent.author == newEvent.author {
            return self.replaceEvent(newEvent: newEvent)
        } else if self.remove(event: oldEvent) {
            return self.add(event: newEvent)
        }
        
        return false
    }
    
    /// Remove the author at the inner collection.
    ///
    /// - Parameter author: Name of the author.
    /// - Returns: "true" if successful.
    private func removeAuthor(author: String) -> Bool {
        self.eventsByAuthor.removeValue(forKey: author)
        for i in 0..<self.authors.count {
            let existAuthor = self.authors[i]
            if existAuthor == author {
                self.authors.remove(at: i)
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
        guard var events = self.eventsByAuthor[newEvent.author] else {
            return false
        }
        
        for i in 0..<events.count {
            let event = events[i]
            if event.eventId == newEvent.eventId {
                events[i] = newEvent
                self.eventsByAuthor.updateValue(events, forKey: newEvent.author)
                return true
            }
        }
        
        return false
    }
}
