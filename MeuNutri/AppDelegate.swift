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
        window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        HealthDataService.shared.requestPermission { [unowned self] (success, error) in
            if let error = error {
                print(error)
            } else {
                DispatchQueue.main.async { [unowned self] in
                    self.window?.rootViewController = OnboardBuilder().build()
                    self.window?.makeKeyAndVisible()
                }
            }
        }

        return true
    }
}
