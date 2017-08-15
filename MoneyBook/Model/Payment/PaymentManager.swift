//
//  PaymentManager.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/08/15.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import Foundation
import StoreKit

enum MBError : Error {
    case invalidAppStoreReceiptURL
    case invalidURL(url:String)
}

enum ReceiptStatusError : Error {
    case invalidJson
    case invalidReceiptDataProperty
    case authenticationError
    case commonSecretKeyMisMatch
    case receiptServerError
    case invalidReceiptForProduction
    case invalidReceiptForSandbox
    case unknownError
    
    static func statusForErrorCode (_ _code: Any?) -> ReceiptStatusError? {
        guard let code = _code as? Int else {
            return .unknownError
        }
        switch code {
        case 0:
            return nil
        case 21000:
            return .invalidJson
        case 21002:
            return .invalidReceiptDataProperty
        case 21003:
            return .authenticationError
        case 21004:
            return .commonSecretKeyMisMatch
        case 21005:
            return .receiptServerError
        case 21007:
            return .invalidReceiptForProduction
        case 21008:
            return .invalidReceiptForSandbox
        default:
            return .unknownError
        }
    }
}

///// protocol
@objc protocol PaymentManagerDelegate {
    //optional func purchaseManager()
    @objc optional func purchaseManager(purchaseManager: PaymentManager, didFinishPurchaseWithTransaction transaction: SKPaymentTransaction!, decisionHandler: ((_ complete : Bool) -> Void)!)
    @objc optional func purchaseManager(purchaseManager: PaymentManager, didFinishUntreatedPurchaseWithTransaction transaction: SKPaymentTransaction!, decisionHandler: ((_ complete : Bool) -> Void)!)
    @objc optional func purchaseManagerDidFinishRestore(purchaseManager: PaymentManager)
    @objc optional func purchaseManager(purchaseManager: PaymentManager, didFailWithError error: NSError!)
    @objc optional func purchaseManagerDidDeferred(purchaseManager: PaymentManager)
}

fileprivate let singleton = PaymentManager()

class PaymentManager : NSObject, SKPaymentTransactionObserver {
    var delegate : PaymentManagerDelegate?
    
    fileprivate var productIdentifier : String?
    fileprivate var isRestore : Bool = false
    fileprivate static var receiptStatus : ReceiptStatusError? = nil
    
    fileprivate static var verifyReceiptUrlString : String {
        //#if DEBUG
        //    return "https://sandbox.itunes.apple.com/verifyReceipt"
        //#else
        //    return "https://buy.itunes.apple.com/verifyReceipt"
        //#endif
        return "https://sandbox.itunes.apple.com/verifyReceipt"
    }
    
    fileprivate static var verifyReceiptUrl : URL? {
        return URL(string : verifyReceiptUrlString)
    }
    fileprivate static var password : String {
        return "xxxxxxxxxxxxxxxxxxxxxxxxxx" //iTunes ConnectにおけるApp内課金で発行される共有シークレット
    }
    
    class func shared() -> PaymentManager {
        return singleton
    }
    
    func startWithProduct(product: SKProduct) {
        var errorCount = 0
        var errorMessage = ""
        
        if SKPaymentQueue.canMakePayments() == false {
            errorCount += 1
            errorMessage = "設定で購入が無効になっています。"
        }
        if productIdentifier != nil {
            errorCount += 10
            errorMessage = "課金処理中です。"
        }
        if isRestore == true {
            errorCount += 100
            errorMessage = "リストア中です。"
        }
        if errorCount > 0 {
            let error = NSError(domain: "PurchaseErrorDomain", code: errorCount, userInfo: [NSLocalizedDescriptionKey:errorMessage + "(\(errorCount))"])
            delegate?.purchaseManager!(purchaseManager: self, didFailWithError: error)
            return
        }
        
        let payment = SKMutablePayment(product: product)
        SKPaymentQueue.default().add(payment)
        productIdentifier = product.productIdentifier
    }

    func startRestore () {
        if isRestore == false {
            isRestore = true
            SKPaymentQueue.default().restoreCompletedTransactions()
        } else {
            let error = NSError(domain: "PurchaseErrorDomain", code: 0,
                                userInfo: [NSLocalizedDescriptionKey:"リストア処理中です。"])
            delegate?.purchaseManager?(purchaseManager: self, didFailWithError: error)
        }
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing :
                break
            case .purchased :
                completeTransaction(transaction: transaction)
            case .failed :
                failedTransaction(transaction: transaction)
            case .restored :
                restoreTransaction(transaction: transaction)
            case .deferred :
                deferredTransaction(transaction: transaction)
            }
        }
    }
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        delegate?.purchaseManager?(purchaseManager: self, didFailWithError: error as NSError!)
        isRestore = false
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        delegate?.purchaseManagerDidFinishRestore?(purchaseManager: self)
        isRestore = false
    }
    
    private func completeTransaction(transaction : SKPaymentTransaction) {
        if transaction.payment.productIdentifier == productIdentifier {
            delegate?.purchaseManager?(purchaseManager: self, didFinishPurchaseWithTransaction: transaction, decisionHandler: { (complete) -> Void in
                if complete == true {
                    SKPaymentQueue.default().finishTransaction(transaction)
                    PaymentManager.checkReceipt()
                }
            })
            productIdentifier = nil
        } else {
            delegate?.purchaseManager?(purchaseManager: self, didFinishUntreatedPurchaseWithTransaction: transaction, decisionHandler: { (complete) -> Void in
                if complete == true {
                    SKPaymentQueue.default().finishTransaction(transaction)
                    PaymentManager.checkReceipt()
                }
            })
        }
    }
    
    fileprivate func failedTransaction(transaction : SKPaymentTransaction) {
        delegate?.purchaseManager?(purchaseManager: self, didFailWithError: transaction.error as NSError!)
        productIdentifier = nil
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    fileprivate func restoreTransaction(transaction : SKPaymentTransaction) {
        switch transaction.transactionState {
        case .purchasing :
            break
        case .purchased :
            break
        case .failed :
            break
        case .restored :
            break
        case .deferred :
            break
        }
        
        delegate?.purchaseManager?(purchaseManager: self, didFinishPurchaseWithTransaction: transaction.original, decisionHandler: { (complete) -> Void in
            if complete == true {
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        })
    }
    
    fileprivate func deferredTransaction(transaction : SKPaymentTransaction) {
        delegate?.purchaseManagerDidDeferred?(purchaseManager: self)
        productIdentifier = nil
    }
    
    public static func checkReceipt() {
        do {
            let reqeust = try getReceiptRequest()
            let session = URLSession.shared
            let task = session.dataTask(with: reqeust, completionHandler: {(data, response, error) -> Void in
                guard let jsonData = data else { return }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: .init(rawValue: 0)) as AnyObject
                    receiptStatus = ReceiptStatusError.statusForErrorCode(json.object(forKey: "status"))
                    guard let latest_receipt_info = (json as AnyObject).object(forKey: "latest_receipt_info") else { return }
                    guard let receipts = latest_receipt_info as? [[String: AnyObject]] else { return }
                    updateStatus(receipts: receipts)
                } catch let error {
                    print("PaymentManager : Failure to validate receipt: \(error)")
                }
            })
            task.resume()
        } catch let error {
            print("PaymentManager : Failure to process payment from Apple store: \(error)")
            checkReceiptInLocal()
        }
    }
    
    fileprivate static func checkReceiptInLocal() {
        let expiresDateMs : UInt64 = 0 //ローカルから取り出してくる
        let nowDateMs: UInt64 = getNowDateMs()
        
        if nowDateMs <= expiresDateMs {
            print("OK")
        }
    }
    
    fileprivate static func getReceiptRequest() throws -> URLRequest {
        guard let receiptUrl = Bundle.main.appStoreReceiptURL else {
            throw MBError.invalidAppStoreReceiptURL
        }
        
        let receiptData = try Data(contentsOf: receiptUrl)
        let receiptBase64Str = receiptData.base64EncodedString(options: .endLineWithCarriageReturn)
        let requestContents = ["receipt-data": receiptBase64Str, "password": password]
        let requestData = try JSONSerialization.data(withJSONObject: requestContents, options: .init(rawValue: 0))
        
        
        guard let verifyUrl = verifyReceiptUrl else {
            throw MBError.invalidURL(url: verifyReceiptUrlString)
        }
        var request = URLRequest(url: verifyUrl)
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"content-type")
        request.timeoutInterval = 5.0
        request.httpMethod = "POST"
        request.httpBody = requestData
        
        return request
    }
    
    fileprivate static func updateStatus(receipts: [[String: AnyObject]]) {
        var productId: String = ""
        var expiresDateMs: UInt64 = 0
        for receipt in receipts {
            productId = receipt["product_id"] as? String ?? ""
            expiresDateMs = UInt64(receipt["expires_date_ms"] as? String ?? "0") ?? 0
            let nowDateMs: UInt64 = getNowDateMs()
            if nowDateMs <= expiresDateMs
                && receiptStatus == nil
                && productId == "xxx.xxx.xxx.xxx" {
                print("OK")
            }
        }
        //ローカルのデータを更新
        //productID, purchaseDateMs, expiresDateMs, isTrialPeriod など
    }
    
    fileprivate static func getNowDateMs() -> UInt64 {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateNowStr: String = formatter.string(from: Date())
        guard let now: Date = formatter.date(from: dateNowStr) else { return 0 }
        let dateNowUnix: TimeInterval = (now.timeIntervalSince1970)
        
        return UInt64(dateNowUnix) * 1000
    }

}







