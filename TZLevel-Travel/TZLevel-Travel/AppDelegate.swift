//
//  AppDelegate.swift
//  TZLevel-Travel
//
//  Created by Alexander Orlov on 07.05.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let layout = UICollectionViewFlowLayout()
        let mainViewController = CollectionViewController(collectionViewLayout: layout)
        navController = UINavigationController(rootViewController: mainViewController)
        navController?.navigationBar.isTranslucent = false
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

