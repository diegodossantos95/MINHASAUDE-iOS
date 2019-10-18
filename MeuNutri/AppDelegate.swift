//
//  AppDelegate.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 14/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SyncBuilder().build()//OnboardBuilder().build()
        window?.makeKeyAndVisible()

        return true
    }
}
