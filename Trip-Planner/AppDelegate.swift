//
//  AppDelegate.swift
//  Trip-Planner
//
//  Created by Kaichi Momose on 2017/12/06.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//    var user: User?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //Override point for customization after application launch.
        let defaults = UserDefaults.standard
        let initialViewController: UIViewController
//        let user = defaults.data(forKey: "currentUser")
        if let userData = defaults.object(forKey: "currentUser") as? Data,
            let user = NSKeyedUnarchiver.unarchiveObject(with: userData) as? User {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            User.setCurrent(user)
            initialViewController = storyboard.instantiateInitialViewController()!
        } else {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            initialViewController = storyboard.instantiateInitialViewController()!
        }
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        return true
    }

}


