//
//  AppDatabaseManager.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/03.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit
import FMDB

/// Manage for the application data.
class AppDatabaseManager: NSObject {
    /// Manage for the Events.
    private(set) var eventService: EventService!
    
    /// Factory of a data access objects.
    private let daoFactory = DAOFactory()
    
    /// Initialize the instance.
    override init() {
        super.init()
        self.eventService = EventService(daoFactory: self.daoFactory)
    }
}
