//
//  AppDelegate.swift
//  FileManager
//
//  Created by Naveen Chauhan on 05/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var appWindow: UIWindow = {
        let w = UIWindow(frame: UIScreen.main.bounds)
        return w
    }()
    var rootNavigationController : UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let homedashboard = DashboardTabBarController()
        self.rootNavigationController = UINavigationController(rootViewController: homedashboard)
        self.appWindow.rootViewController = self.rootNavigationController
        self.appWindow.makeKeyAndVisible()
        return true
    }

   
}

