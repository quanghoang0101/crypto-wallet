//
//  AppDelegate.swift
//  cryto-wallet
//
//  Created by Hoang on 9/9/21.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        Application.shared.configureMainInterface(in: window!)
        return true
    }

}

