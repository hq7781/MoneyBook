//
//  ProductManager.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/08/15.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import Foundation
import StoreKit

fileprivate var productManagers : Set<ProductManager> = Set()

class ProductManager: NSObject, SKProductsRequestDelegate {
    static var subscriptionProduct : SKProduct? = nil
    
    fileprivate var completion : (([SKProduct]?,NSError?) -> Void)?
    
    static func getProducts(withProductIdentifiers productIdentifiers :
        [String],completion:(([SKProduct]?,NSError?) -> Void)?){
        let productManager = ProductManager()
        productManager.completion = completion
        let request = SKProductsRequest(productIdentifiers: Set(productIdentifiers))
        request.delegate = productManager
        request.start()
        
        productManagers.insert(productManager)
    }
    
    static func getSubscriptionProduct(completion:(() -> Void)? = nil) {
        guard ProductManager.subscriptionProduct == nil else {
            if let completion = completion {
                completion()
            }
            return
        }
        
        let productIdentifier = "xxx.xxx.xxx.xxx"
        
        ProductManager.getProducts(withProductIdentifiers:
            [productIdentifier], completion: { (_products, error) -> Void in
            if let product = _products?.first {
                ProductManager.subscriptionProduct = product
            }
            if let completion = completion {
                completion()
            }
        })
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        var error : NSError? = nil
        if response.products.count == 0 {
            error = NSError(domain: "ProductsRequestErrorDomain",
                            code: 0, userInfo: [NSLocalizedDescriptionKey:"プロダクトを取得できませんでした。"])
        }
        completion?(response.products, error)
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        let error = NSError(domain: "ProductsRequestErrorDomain",
                            code: 0, userInfo: [NSLocalizedDescriptionKey:"プロダクトを取得できませんでした。"])
        completion?(nil,error)
        productManagers.remove(self)
    }
    
    func requestDidFinish(_ request: SKRequest) {
        productManagers.remove(self)
    }
}
