//
//  NotificationManager.swift
//  viridian-ios
//
//  Created by Jaime Gutierrez on 8/25/15.
//  Copyright (c) 2016 Moi Gutierrez. All rights reserved.
//

import UIKit
import CRToast
import Colours

class NotificationManager {

    static let sharedInstance = NotificationManager()
    
    let kNotificationDuration = 1.6
    
    var notifications = [CRToastManager]()
    
    var lastMessage = String()
    
    func alertWithMessage(message: String) {

        if lastMessage == message{
            return
        }
        lastMessage = message
//        CRToastManager.dismissNotification(true)
        let options: NSMutableDictionary = [
//            kCRToastImageKey : (UIImage(named: "alert_icon") as AnyObject?)!,
            kCRToastFontKey: UIFont.boldSystemFontOfSize(18.0),
            kCRToastTextKey : String(message),
            kCRToastTextAlignmentKey : NSTextAlignment.Center.rawValue,
            kCRToastBackgroundColorKey : UIColor.redColor(),
            kCRToastNotificationTypeKey: CRToastType.NavigationBar.rawValue,
            kCRToastAnimationInTypeKey : CRToastAnimationType.Spring.rawValue,
            kCRToastAnimationOutTypeKey : CRToastAnimationType.Gravity.rawValue,
            kCRToastAnimationInDirectionKey : CRToastAnimationDirection.Bottom.rawValue,
            kCRToastAnimationOutDirectionKey : CRToastAnimationDirection.Top.rawValue,
            kCRToastTimeIntervalKey: kNotificationDuration,
        ]
        CRToastManager.showNotificationWithOptions(options as [NSObject : AnyObject], completionBlock: {
            self.lastMessage = ""
            NSLog("Notification (Alerted)")
        })
    }
    
    func completionWithMessage(message: String) {
        
        if lastMessage == message{
            return
        }
        lastMessage = message
//        CRToastManager.dismissNotification(true)
        let options: NSMutableDictionary = [
//            kCRToastImageKey : (UIImage(named: "teal_checkmark") as AnyObject?)!,
            kCRToastFontKey: UIFont.systemFontOfSize(18.0),
            kCRToastTextKey : String(message),
            kCRToastTextAlignmentKey : NSTextAlignment.Center.rawValue,
            kCRToastBackgroundColorKey : UIColor.seafoamColor(),
            kCRToastNotificationTypeKey: CRToastType.NavigationBar.rawValue,
            kCRToastAnimationInTypeKey : CRToastAnimationType.Spring.rawValue,
            kCRToastAnimationOutTypeKey : CRToastAnimationType.Gravity.rawValue,
            kCRToastAnimationInDirectionKey : CRToastAnimationDirection.Bottom.rawValue,
            kCRToastAnimationOutDirectionKey : CRToastAnimationDirection.Top.rawValue,
            kCRToastTimeIntervalKey: kNotificationDuration,
        ]

        CRToastManager.showNotificationWithOptions(options as [NSObject : AnyObject], completionBlock: {
            self.lastMessage = ""
            NSLog("Notification (Completed)")
        })
    }
}
