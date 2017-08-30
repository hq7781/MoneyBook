//
//  SimpleNetwork.swift
//  MoneyBook
//
//  Created by HONGQUAN on 7/14/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

public class SimpleNetwork {

    public typealias Completion = (_ result: AnyObject?, _ error: NSError?) -> ()
    
    func demoGCDGroup() {
        let group = DispatchGroup()
        let queue = DispatchQueue.global()
        queue.async(group:group) {
            () -> Void in
            print("queue done.")
        }
        group.notify(queue: DispatchQueue.main) {
            () -> Void in // すべてのタスク完了後、callback
            print("all task done.")
        }
    }
    
    /*
     * Download image files
     *
     */
    func downloadImages(urls: [String], _ completion: @escaping Completion) {
        
        let group = DispatchGroup()
        
        for url in urls {
            group.enter() //dispatch_group_enter(group)

            //downloadImage(urlString: [url]) {
            downloadImage(urlString: url) {
                (result,error) -> () in
                group.leave()//dispatch_group_leave(group)
            }
        }
        
        //dispatch_group_notify(group, dispatch_get_main_queue()) {
        group.notify(queue: DispatchQueue.main) {
            () -> Void in
            completion(nil,nil)
        }
    }
    
    /*
     * Download a image file to sandbox
     *
     */
    func downloadImage(urlString:String, _ completion: @escaping Completion) {
        var path = urlString //urlString.md5
        let tmpPath = cachePath! as NSString
        path = tmpPath.appendingPathComponent(path)
        
        if FileManager.default.fileExists(atPath: path) {
            completion(nil, nil)
            return
        }
        if let url = NSURL(string: urlString) {
            self.session!.downloadTask(with: url as URL) {
                (locaion, _, error) -> Void in
                
                if error != nil {
                    completion(nil, error as NSError?)
                    return
                }
                
                do {
                    try FileManager.default.copyItem(atPath: locaion!.path,toPath:path)
                } catch _ {
                }
                completion(nil, nil)
            }.resume()
        }
    }
    
    lazy var cachePath: String? = {
        var path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory,
                                                       FileManager.SearchPathDomainMask.userDomainMask,true).last!
        let tmpPath = path as NSString
        path = tmpPath.appendingPathComponent(imageCachePath)
        
        var isDirectory: ObjCBool = true
        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        
        if exists && !isDirectory.boolValue {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch _ {
            }
        }
        
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch _ {
        }
        
        return path
    }()
    
    private static var imageCachePath = kAppImageCachePath
    
    /*
     * Download a image file to sandbox
     *
     */
    public func requestJSON(method:HTTPMethod, _ urlString: String,
                            _ params:[String:String]?,
                            completion: @escaping Completion) {
        if let request = request(method:method, urlString, _params: params) {
            session!.dataTask(with: request as URLRequest, completionHandler: {
                (data, _, error) -> Void in
                
                if error != nil {
                    completion(nil, error as NSError?)
                    return
                }
                
                let json: AnyObject? = try! JSONSerialization.jsonObject(with:data!, options: .allowFragments) as AnyObject?//JSONReadingOptions)
                
                if json == nil {
                    let error = NSError(domain:SimpleNetwork.errorDomain, code:-1, userInfo:["error":"JSON Serialization Failed!"])
                    completion(nil,error)
                } else {
                    DispatchQueue.main.async {
                        () -> Void in
                        completion(json, nil)
                    }
                }
            }).resume()
            
            return
        }
        
        let error = NSError(domain:SimpleNetwork.errorDomain, code: -1, userInfo:["error":"Request connection Failed"])
        completion(nil, error)
    }
    
    static let errorDomain = "com.enixsoft.error"
    /*
     * network access request
     */
    func request (method: HTTPMethod, _ urlString:String, _params: [String:String]?) -> NSURLRequest?{
    
        if urlString.isEmpty {
            return nil
        }
        
        var urlStr = urlString
        var r: NSMutableURLRequest?
        
        if method == .GET {
            let query = queryString(params: _params)
            if query != nil {
                urlStr += "?" + query!
            }
            
            r = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL)
        } else {
            if let query = queryString(params: _params) {
                r = NSMutableURLRequest(url:NSURL(string:urlStr)! as URL)
                r!.httpMethod = method.rawValue
                r!.httpBody = query.data(using:String.Encoding.utf8, allowLossyConversion:true)
            }
        }
        
        return r
    }
    /*
     * create query string
     *
     */
    func queryString(params:[String:String]?) -> String? {
        if params == nil {
            return nil
        }
        
        var array = [String]()
        
        for (key, value) in params! {
            let str = key + "=" + value.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.alphanumerics)!
            array.append(str)
        }
        
        return array.joined(separator:"&")
    }
    
    public func cancelAllNetwork() {
        session?.delegateQueue.cancelAllOperations()
    }
    
    public init() {
    }
    
    lazy var session: URLSession? = {
        return URLSession.shared
    }()
}























