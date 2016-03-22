//
//  WhoIsMyRepRequestOperationManager.swift
//  WhoIsMyRep
//
//  Copyright © 2016 Moi Gutierrez. All rights reserved.
//

import UIKit
import Alamofire

class WhoIsMyRepRequestOperationManager : NSURLSession {
    
    var hideProgressIfQueueIsEmptyOnly = true
    var disableHudForNextRequest = true
    var disableHudUrls = [String]()

    class func codeIsBad(code:Int)-> Bool{
        switch code {
        case 200 ... 299:
            print("success code: \(code)")
            return false
        case 400 ... 499:
            print("failure error: \(code)")
            return true
        default:
            return false
        }

    }
    
    override func dataTaskWithRequest(request: NSURLRequest) -> NSURLSessionDataTask {
        
        let urlString = request.URL!.absoluteString
        if !disableHudUrls.contains(urlString) {
            ProgressHudManager.sharedInstance.show()
        } else {
            disableHudUrls = disableHudUrls.filter { $0 != urlString }
        }
        
        let successWithHud : ((NSURLSessionTask, AnyObject) -> Void)? = {
            [unowned self] (operation, response) -> Void in
            
            if self.shouldHideProgressHud {
                ProgressHudManager.sharedInstance.hide()
            }
        }
        let failureWithHud : ((NSURLSessionTask, NSError) -> Void)? = {
            (operation, error) -> Void in
            
            if self.shouldHideProgressHud {
                ProgressHudManager.sharedInstance.hide()
            }
        }
        
        return super.dataTaskWithRequest(request)
    }
    
    
    var shouldHideProgressHud: Bool {
        get {
            return !hideProgressIfQueueIsEmptyOnly ||
                (hideProgressIfQueueIsEmptyOnly && self.delegateQueue.operationCount == 0)
        }
    }
    
}