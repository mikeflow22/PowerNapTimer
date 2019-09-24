//
//  AppDelegate.swift
//  PowerNapTimer
//
//  Created by Michael Flowers on 9/24/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //get the usernotification  framework
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .criticalAlert, .alert]) { (granted, error) in
            <#code#>
        }
        return true
    }


}

