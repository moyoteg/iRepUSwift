//
//  RequestExtensions.swift
//  iRepUSwift
//
//  Created by Jaime Moises Gutierrez on 3/16/16.
//  Copyright © 2016 MoiGtz. All rights reserved.
//

import Foundation
import Alamofire

extension Request {
    
    public func debugLog() -> Self {
        #if DEBUG
            debugPrint(self)
        #endif
        return self
    }
    
    public func showHUD() -> Self {
        ProgressHudManager.sharedInstance.show()
        return self
    }
    
    public func setTimeOut() -> Self {
        
        // NOT IMPLEMENTED YET
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 4 // seconds
        configuration.timeoutIntervalForResource = 4
        
        //TODO: setup a timeout to current session
        
        return self
    }
    
    public func checkConnectivity() -> Self {
        if !ConnectivityManager.sharedInstance.reachability.isReachable(){
            self.cancel()
            NotificationManager.sharedInstance.alertWithMessage("No Internet Connection Available")
        }
        return self
    }
    
}