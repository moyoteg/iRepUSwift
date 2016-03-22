//
//  ProgressHudManager.swift
//  WhoIsMyRep
//
//  Created by Mikhail Churbanov on 26.11.15.
//  Copyright © 2016 Moi Gutierrez. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class ProgressHudManager : NSObject {
    
    static var sharedInstance = ProgressHudManager()
    
    let progressHud = MBProgressHUD()
    var onHudWasHidden: (() -> Void)?
    var continousRequests: Int = 0
    
    override init() {
        super.init()
        
        progressHud.userInteractionEnabled = true
        progressHud.backgroundColor = UIColor.groupTableViewBackgroundColor().colorWithAlphaComponent(0.6)
        progressHud.color = Constants.WhoIsMyRepPrimaryColor
        progressHud.mode = .Indeterminate
        progressHud.detailsLabelText = "Loading..."
        progressHud.removeFromSuperViewOnHide = true
    }
    
    func show() {
        UIApplication.sharedApplication().keyWindow?.addSubview(progressHud)
        progressHud.taskInProgress = true
        progressHud.show(true)
    }
    
    func hide() {
        if continousRequests > 0 && continousRequests-- > 1 {
            return
        }
        progressHud.taskInProgress = false
        progressHud.hide(true)
    }
    
    func isLoading() -> Bool {
        return progressHud.taskInProgress
    }
    
    func onCompletion(completionBlock: MBProgressHUDCompletionBlock?, executeOnceOnly: Bool) {
        if !executeOnceOnly {
            progressHud.completionBlock = completionBlock
        } else {
            progressHud.completionBlock = {
                if let completionBlock = completionBlock {
                    completionBlock()
                }
                self.progressHud.completionBlock = nil
            }
        }
    }
    
    func disableForNextRequest() {
        if let manager = Alamofire.Manager.sharedInstance as? WhoIsMyRepRequestOperationManager {
            manager.disableHudForNextRequest = true
        }
    }
    
}
