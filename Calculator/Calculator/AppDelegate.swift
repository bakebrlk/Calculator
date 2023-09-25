//
//  AppDelegate.swift
//  Calculator
//
//  Created by bakebrlk on 25.09.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        
        return true
    }



}

