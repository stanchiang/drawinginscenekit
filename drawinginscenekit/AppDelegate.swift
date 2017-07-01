//
//  AppDelegate.swift
//  drawinginscenekit
//
//  Created by Stanley Chiang on 6/16/17.
//  Copyright © 2017 Stanley Chiang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = UITabBarController()
        let controllers = [LineIn3dViewController(),HandwriteTo3DViewController()]
        
        tabBarController.viewControllers = controllers
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

}

