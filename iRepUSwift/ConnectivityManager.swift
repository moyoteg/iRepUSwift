//
//  ConnectivityManager.swift
//  viridian-ios
//
//  Created by Jaime Moises Gutierrez on 9/25/15.
//  Copyright (c) 2016 Moi Gutierrez. All rights reserved.
//

import Foundation
import ReachabilitySwift

class ConnectivityManager: NSObject {

    static let sharedInstance = ConnectivityManager()
    
    let reachability = try! Reachability.reachabilityForInternetConnection()
    
    var hasInternet:Bool = false {
        didSet {
            printReachabilityStatus()
        }
    }
    
    override init() {
        super.init()
        // Setup reachability
        self.reachability.whenReachable = { reachability in
            
            if reachability.isReachableViaWiFi() {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            
            self.hasInternet = true
        }
        
        self.reachability.whenUnreachable = { reachability in
            self.hasInternet = false
        }
        
        try! reachability.startNotifier()
        
        // Initial reachability check
        if self.reachability.isReachable() {
            self.hasInternet = true
            printReachabilityStatus()
        } else {
            self.hasInternet = false
            printReachabilityStatus()
        }        
    }

    private func printReachabilityStatus() {
        if(self.hasInternet){
            print("internet reachable")
            NotificationManager.sharedInstance.completionWithMessage("Internet Connection Available")
        }else{
            print("internet not reachable")
            NotificationManager.sharedInstance.alertWithMessage("Internet Connection Lost")

        }
    }
}
