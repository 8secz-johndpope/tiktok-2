import SwiftyStoreKit

class PurchaseHelper {
    
    static let shared = PurchaseHelper()
    
    func getProductsInfo() {
        SwiftyStoreKit.retrieveProductsInfo([Constants.productId]) { results in
            for item in results.retrievedProducts {
                UserDefaults.standard.set(item.localizedPrice, forKey: Constants.productPrice)
            }
        }
    }
    
    func completeIAPTransactions() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                if purchase.transaction.transactionState == .purchased || purchase.transaction.transactionState == .restored {

                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                    NSLog("purchased: \(purchase.productId)")
                }
            }
        }
    }
    
    func purchase(_ completion: @escaping (UIAlertController?) -> Void) {
        SwiftyStoreKit.purchaseProduct(Constants.productPrice, atomically: true) { result in
            switch result {
            case .success(let purchase):
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
            case .error:
                completion(self.alertForPurchaseResult(result, handler: nil))
            }
        }
    }
}

extension PurchaseHelper {

    func alertWithTitle(_ title: String, message: String, handler: ((UIAlertAction) -> Swift.Void)?) -> UIAlertController {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handler))
        return alert
    }

    func alertForPurchaseResult(_ result: PurchaseResult, handler: ((UIAlertAction) -> Swift.Void)?) -> UIAlertController? {
        switch result {
        case .success(let purchase):
            NSLog("Purchase Success: \(purchase.productId)")
            return alertWithTitle("Thank You", message: "Purchase completed", handler: handler)
        case .error(let error):
            NSLog("Purchase Failed: \(error)")
            switch error.code {
            case .unknown: return alertWithTitle("Purchase failed", message: error.localizedDescription, handler: handler)
            case .clientInvalid: // client is not allowed to issue the request, etc.
                return alertWithTitle("Purchase failed", message: "Not allowed to make the payment", handler: handler)
            case .paymentCancelled: // user cancelled the request, etc.
                return nil
            case .paymentInvalid: // purchase identifier was invalid, etc.
                return alertWithTitle("Purchase failed", message: "The purchase identifier was invalid", handler: handler)
            case .paymentNotAllowed: // this device is not allowed to make the payment
                return alertWithTitle("Purchase failed", message: "The device is not allowed to make the payment", handler: handler)
            case .storeProductNotAvailable: // Product is not available in the current storefront
                return alertWithTitle("Purchase failed", message: "The product is not available in the current storefront", handler: handler)
            case .cloudServicePermissionDenied: // user has not allowed access to cloud service information
                return alertWithTitle("Purchase failed", message: "Access to cloud service information is not allowed", handler: handler)
            case .cloudServiceNetworkConnectionFailed: // the device could not connect to the nework
                return alertWithTitle("Purchase failed", message: "Could not connect to the network", handler: handler)
            case .cloudServiceRevoked: // user has revoked permission to use this cloud service
                return alertWithTitle("Purchase failed", message: "Cloud service was revoked", handler: handler)
            default:
                return alertWithTitle("Purchase failed", message: "Cloud service was revoked", handler: handler)
            }
        }
    }

    func alertForRestorePurchases(_ results: RestoreResults, handler: ((UIAlertAction) -> Swift.Void)?) -> UIAlertController? {

        if results.restoreFailedPurchases.count > 0 {
            NSLog("Restore Failed: \(results.restoreFailedPurchases)")
            return alertWithTitle("Restore failed", message: "Unknown error. Please contact support", handler: handler)
        } else if results.restoredPurchases.count > 0 {
            NSLog("Restore Success: \(results.restoredPurchases)")
            return alertWithTitle("Purchases Restored", message: "All purchases have been restored", handler: handler)
        } else {
            NSLog("Nothing to Restore")
            return alertWithTitle("Nothing to restore", message: "No previous purchases were found", handler: handler)
        }
    }

    func alertForVerifyReceipt(_ result: VerifyReceiptResult, handler: ((UIAlertAction) -> Swift.Void)?) -> UIAlertController {

        switch result {
        case .success(let receipt):
            NSLog("Verify receipt Success: \(receipt)")
            return alertWithTitle("Receipt verified", message: "Receipt verified remotely", handler: handler)
        case .error(let error):
            NSLog("Verify receipt Failed: \(error)")
            switch error {
            case .noReceiptData:
                return alertWithTitle("Receipt verification", message: "No receipt data. Try again.", handler: handler)
            case .networkError(let error):
                return alertWithTitle("Receipt verification", message: "Network error while verifying receipt: \(error)", handler: handler)
            default:
                return alertWithTitle("Receipt verification", message: "Receipt verification failed: \(error)", handler: handler)
            }
        }
    }

    func alertForVerifySubscription(_ result: VerifySubscriptionResult, handler: ((UIAlertAction) -> Swift.Void)?) -> UIAlertController? {
        switch result {
        case .purchased(let expiryDate, _):
            NSLog("Product is valid until \(expiryDate)")
            //            return alertWithTitle("Product is purchased", message: "Product is valid until \(expiryDate)")
            return alertWithTitle("Success", message: "Product is valid until \(expiryDate)", handler: handler)
        case .expired(let expiryDate, _):
            NSLog("Product is expired since \(expiryDate)")
            //            return alertWithTitle("Product expired", message: "Product is expired since \(expiryDate)")
            return alertWithTitle("Product expired", message: "Product is expired since \(expiryDate)", handler: handler)
        case .notPurchased:
            NSLog("This product has never been purchased")
            return alertWithTitle("Not purchased", message: "This product has never been purchased", handler: handler)
        }
    }
}

