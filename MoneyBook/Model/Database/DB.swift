//
//  DB.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/01.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import Foundation
class DB {
//    let sqlLite3 = try! SqlLite3()
    
    let index : Dictionary<String,[String]>! = [
        "category": ["category1","category2","category3"],
        "Payment": ["cash","card","bannking","jiekuan","","","",""],
        "Type": ["inCome","OutCome","other"],
        "memo1": ["1","2","3","4","5","6"],
        "memo2": ["1","2","3","4","5"],
        "memo3": ["1","2","3","4","5"],
        "memo4": ["1","2","3","4","5"],
        "memo5": ["1","2","3","4","5"],
        "memo6": ["1","2","3","4","5"],
        "memo7": ["1","2","3"],]
    
    let account = ["chsh","ATM","Bannking","Card"]
    
    class func share() -> DB{
        let share = DB()
        return share
    }
    
    func writeData(_ obj : Object){
//        try! sqlLite3.write {
//            sqlLite3.add(obj)
//            print("add")
//        }
    }
    
    //func queryIndex() -> Results<Index> {
    func queryIndex() -> String {
        //let data = sqlLite3.objects(Index.self)
        let data = ""
        return data
    }
    
    //func queryAccount() -> Results<Account>{
    func queryAccount() -> String {
        //let data = sqlLite3.objects(Account.self)
        let data = ""
        return data
    }
    
    func setupBasicDB() {
        let indexKeys = Array(index.keys)
        for i in 0...indexKeys.count-1 {
            let indexObj = Index()
            indexObj.dadName = indexKeys[i]
            let ind = index[indexKeys[i]]!
            for j in 0...ind.count-1 {
                let indexChil = ChildIndex()
                indexChil.childName = ind[j]
//                indexObj.childName.append(indexChil)
            }
            writeData(indexObj)
        }
        
        for acc in 0...account.count - 1 {
            let acc1 = Account()
            acc1.nameAcc = account[acc]
            if acc == 0 {
                acc1.image = "account_wallet.png"
            } else if acc == 1 {
                acc1.image = "bank.png"
            } else if acc == 2 {
                acc1.image = "account_invest.png"
            }
            self.writeData(acc1)
        }
    }
    
    func insertChildToParentIndex(_ parentName :String , child : ChildIndex) {
//        let index = sqlLite3.objects(Index.self).filter("dadName = %@",parentName).first
        
//        try! sqlLite3.write {
//            index?.childName.append(child)
//        }
    }
    
    func saveRecord(_ record : Record){
//        try! sqlLite3.write {
//            sqlLite3.add(record)
//        }
    }
}
