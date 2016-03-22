//
//  ErrorAlertManager.swift
//  WhoIsMyRep
//
//  Created by Moi Gutierrez on 9/13/15.
//  Copyright (c) 2016 Moi Gutierrez. All rights reserved.
//

import UIKit

enum BlockButtonType {
    case Default
    case Destructive
    case Cancel
}

typealias ActionHandlerType = () -> ()

class BlockActionSheet : UIActionSheet, UIActionSheetDelegate {
    var handlers:[Int:ActionHandlerType] = [Int:ActionHandlerType]()
    
    init() {
        super.init(title: nil, delegate:nil, cancelButtonTitle:nil, destructiveButtonTitle:nil)
        delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func addButton(title:String, buttonType:BlockButtonType, handler:ActionHandlerType?) {
        let index = self.addButtonWithTitle(title)
        
        handlers[index] = handler
        
        switch buttonType {
            case .Destructive:
                self.destructiveButtonIndex = index;
                break;
                
            case .Cancel:
                self.cancelButtonIndex = index;
                break;
                
            default:
                break;
        }
    }
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        if let handler = handlers[buttonIndex] {
            handler()
        }
    }
    
}

class BlockAlertView : UIAlertView, UIAlertViewDelegate {
    var handlers:[Int:ActionHandlerType] = [Int:ActionHandlerType]()
    
    init() {
        super.init(frame: CGRectZero)
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func addButton(title:String, buttonType:BlockButtonType, handler:ActionHandlerType?) {
        let index = self.addButtonWithTitle(title)
        
        handlers[index] = handler
        
        switch buttonType {
            case .Cancel:
                self.cancelButtonIndex = index;
                break;
                
            default:
                break;
        }
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if let handler = handlers[buttonIndex] {
            handler()
        }
    }
}



class AlertManager: NSObject {
    
    class func displaySignOutAlert(viewController: UIViewController) {
        // TODO: make this work
    }
    
    class func displayAlertWithError(error: String, viewController: UIViewController) {
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: nil, message: error, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            alertController.view.tintColor = Constants.WhoIsMyRepPrimaryColor
            
            viewController.presentViewController(alertController, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
            let alertView = UIAlertView(title: nil, message: error, delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
        }
    }
    
    class func displayAlertView(title:String?, message:String?, cancelButtonTitle:String, cancelAction:ActionHandlerType?, destructiveButtonTitle:String?, destructiveAction:ActionHandlerType?, otherActions:[(String, ActionHandlerType)], viewController: UIViewController) {
        
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            
            // TODO: tint color gets "forgotten" once user touches a button (on touchesBegan)
            alertController.view.tintColor = Constants.WhoIsMyRepPrimaryColor
            
            if let destructiveButtonTitle = destructiveButtonTitle {
                alertController.addAction(UIAlertAction(title: destructiveButtonTitle, style: .Destructive) {
                        action -> Void in
                        if let destructiveAction = destructiveAction {
                            destructiveAction()
                    }
                    })
            }
            
            for (buttonTitle, buttonAction) in otherActions {
                alertController.addAction(UIAlertAction(title: buttonTitle, style: .Default) {
                        action -> Void in
                        buttonAction()
                    })
            }
            
            
            alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .Cancel) {
                    action -> Void in
                    if let cancelAction = cancelAction {
                        cancelAction()
                    }
                })
            
            viewController.presentViewController(alertController, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
            let alertView = BlockAlertView()
            if let title = title {
                alertView.title = title
            }
            alertView.message = message
            
            // destructive actions are not visible on old alert views
            if let destructiveButtonTitle = destructiveButtonTitle {
                alertView.addButton(destructiveButtonTitle, buttonType: .Destructive, handler: destructiveAction)
            }
            
            for (buttonTitle, buttonAction) in otherActions {
                alertView.addButton(buttonTitle, buttonType: .Default, handler: buttonAction)
            }
            
            
            alertView.addButton(cancelButtonTitle, buttonType: .Cancel, handler: cancelAction)
            
            alertView.show()
        }
    }
    
    
    class func displayActionSheet(cancelButtonTitle:String, cancelAction:ActionHandlerType?, destructiveButtonTitle:String?, destructiveAction:ActionHandlerType?, otherActions:[(String, ActionHandlerType)], viewController: UIViewController) {
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            
            // TODO: tint color gets "forgotten" once user touches a button (on touchesBegan)
            alertController.view.tintColor = Constants.WhoIsMyRepPrimaryColor
            
            if let destructiveButtonTitle = destructiveButtonTitle {
                alertController.addAction(UIAlertAction(title: destructiveButtonTitle, style: .Destructive) {
                    action -> Void in
                    if let destructiveAction = destructiveAction {
                        destructiveAction()
                    }
                })
            }
            
            for (buttonTitle, buttonAction) in otherActions {
                alertController.addAction(UIAlertAction(title: buttonTitle, style: .Default) {
                    action -> Void in
                    buttonAction()
                })
            }
            
            
            alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .Cancel) {
                action -> Void in
                if let cancelAction = cancelAction {
                    cancelAction()
                }
            })
            
            viewController.presentViewController(alertController, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
            let actionSheet = BlockActionSheet()

            // this won't work anyway
            //actionSheet.tintColor = Constants.WhoIsMyRepPrimaryColor
            
            if let destructiveButtonTitle = destructiveButtonTitle {
                actionSheet.addButton(destructiveButtonTitle, buttonType: .Destructive, handler: destructiveAction)
            }
            
            for (buttonTitle, buttonAction) in otherActions {
                actionSheet.addButton(buttonTitle, buttonType: .Default, handler: buttonAction)
            }

            
            actionSheet.addButton(cancelButtonTitle, buttonType: .Cancel, handler: cancelAction)
            
            actionSheet.showInView(viewController.view)
            
        }
    }
    
   
    private class func messageForError(error: String) -> String {
        switch error {
            case "Invalid Request":
            return "Invalid Request"
        default:
            return "Hmmm... No!"
        }
    }
}
