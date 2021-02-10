//
//  AppDelegate.swift
//  ShakespeareanPokemonApp
//
//  Created by daniele salvioni on 06/02/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mainCoordinator: CoordinatorProtocol?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = UINavigationController()
        
        self.mainCoordinator = MainCoordinator(rootController: mainVC)
        self.mainCoordinator?.start()
        
        self.window = window
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
        
        self.logAppInfo()
        
        return true
    }
}

extension AppDelegate {
    
    func logAppInfo() {
        print("""
            *************************** App Info ***************************
            BundleIdentifier: \(Resources.AppInfo.appBundleIdentifier)
            BundleName: \(Resources.AppInfo.appBundleName)
            DisplayName: \(Resources.AppInfo.appDisplayName)
            Version: \(Resources.AppInfo.appVersion)
            BuildVersion: \(Resources.AppInfo.appBuildVersion)
            ****************************************************************
            """)
    }
}

