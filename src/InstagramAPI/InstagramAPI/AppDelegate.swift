//
//  AppDelegate.swift
//  InstagramAPI
//
//  Created by Denis on 12.12.16.
//  Copyright © 2016 ConceptOffice. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //swiftlint:disable:next line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        InstagramClient().endLogin()
        if InstagramClient().isLogged {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //swiftlint:disable:next force_cast line_length
            let controller = storyboard.instantiateViewController(withIdentifier: "RequestViewController") as! RequestViewController
            window?.rootViewController = UINavigationController(rootViewController: controller)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

}
