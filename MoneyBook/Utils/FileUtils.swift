//
//  FileUtils.swift
//  MoneyBook
//
//  Created by HONG QUAN on 7/18/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import UIKit
import SVProgressHUD

class FileUtils: NSObject {
    static let fileManager = FileManager.default
    
    class func fileSize (path: String) -> Double {
        var isDir: ObjCBool = false
        if fileManager.fileExists(atPath: path, isDirectory: &isDir) && isDir.boolValue {
            var dict = try? fileManager.attributesOfItem(atPath: path)
            if let fileSize = dict![FileAttributeKey.size] as? Int {
                return (Double(fileSize) / 1024.0 / 1024.0)
            }
        }
        return 0.0
    }
    
    class func folderSize (path: String) -> Double {
        var folderSize: Double = 0
        if fileManager.fileExists(atPath: path) {
            let chilerFiles = fileManager.subpaths(atPath: path)
            for fileName in chilerFiles! {
                let tmpPath = path as NSString
                let fileFullPathName = tmpPath.appendingPathComponent(fileName)
                folderSize += FileUtils.fileSize(path: fileFullPathName)
            }
            return folderSize
        }
        return 0.0
    }
    /// deep clean
    class func cleanFolder(path: String, complete:@escaping () -> ()) {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
        SVProgressHUD.show(withStatus: "正在清理缓存")

        let queue = DispatchQueue(label:"com.moneybook.cleanQueue")

        queue.async() { () -> Void in
            let chilerFiles = self.fileManager.subpaths(atPath: path)
            for fileName in chilerFiles! {
                let tmpPath = path as NSString
                let fileFullPathName = tmpPath.appendingPathComponent(fileName)
                if self.fileManager.fileExists(atPath: fileFullPathName) {
                    do {
                        try self.fileManager.removeItem(atPath: fileFullPathName)
                    } catch _ {
                    }
                }
            }
            
            // 线程睡1秒 测试,实际用到是将下面代码删除即可
            Thread.sleep(forTimeInterval: 1.0)
            
            DispatchQueue.main.async {
                () -> Void in
                SVProgressHUD.dismiss()
                complete()
            }
        }
    }
}
