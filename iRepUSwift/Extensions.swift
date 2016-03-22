//
//  Extensions.swift
//  iRepUSwift
//
//  Created by Jaime Moises Gutierrez on 3/19/16.
//  Copyright © 2016 MoiGtz. All rights reserved.
//

import UIKit

extension UIView{
    
    func addBackgroundTapKeyboardDismiss(){
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        tapGesture.cancelsTouchesInView = true
        self.addGestureRecognizer(tapGesture)
    }
    
    func hideKeyboard() {
        self.endEditing(true)
    }
    
    func addShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSizeMake(0, 5)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
    }
}

extension UITableViewController{
    
    func addPullToRefresh(action:Selector){
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to clear fields")
        self.refreshControl!.addTarget(self, action: action, forControlEvents: UIControlEvents.ValueChanged)
    }
}