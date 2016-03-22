//
//  AppearanceManager.swift
//  WhoIsMyRep
//
//  Created by Jaime Moises Gutierrez on 12/8/15.
//  Copyright © 2016 Moi Gutierrez. All rights reserved.
//

import UIKit

class AppearanceManager: NSObject {

    static func setupAppApearance(){
        UITabBar.appearance().barTintColor = Constants.WhoIsMyRepPrimaryColor
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "icon-back-arrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "icon-back-arrow")
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    }
}
