//
//  AppDelegate.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Garcia on 01/11/2019.
//  Copyright (c) 2019 Felipe Garcia. All rights reserved.
//

import SwiftJsonThemeManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
     
        // Initialize the Swift JSON Theme Manager with the default one
        _ = ThemeManager.currentTheme

        return true
    }
}

