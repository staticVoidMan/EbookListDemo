//
//  AppDelegate.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let mainVC = EbookListVC()
        mainVC.viewModel = .init(provider: Providers.eBookListProvider)

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

