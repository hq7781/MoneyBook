//
//  NetworkManager.swift
//  MoneyBook
//
//  Created by HongQuan on 7/14/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import Foundation

class NetworkManager: NSObject{
    private static let instance = NetworkManager()
    private let net = SimpleNetwork()
    
    class var sharedManager: NetworkManager{
        return instance;
    }
    
    typealias Completion = (_ result: AnyObject?, _ error: NSError?) ->()
    
    func requestJSON(method: HTTPMethod, _ urlString: String, _ params:[String: String]?,
                           completion: @escaping Completion) {
        net.requestJSON(method:method, urlString, params, completion: completion)
    }
    
    func cancelAllNetwork() {
        net.cancelAllNetwork()
    }
}
