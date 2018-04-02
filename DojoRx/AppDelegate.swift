//
//  AppDelegate.swift
//  DojoRx
//
//  Created by Renan Benatti Dias on 05/03/18.
//  Copyright © 2018 Blue Origami. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        let baseNavigationController = UINavigationController()
        baseNavigationController.viewControllers = [ViewController()]
        window.rootViewController = baseNavigationController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}
