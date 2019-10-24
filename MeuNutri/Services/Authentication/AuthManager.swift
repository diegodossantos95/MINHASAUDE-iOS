//
//  AuthManager.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 19/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit
import FirebaseUI

class AuthManager {
    static let shared = AuthManager()
    private var firebaseAuth: Auth
    private let providers: [FUIAuthProvider] = [
        FUIEmailAuth()
    ]

    private init() {
        firebaseAuth = Auth.auth()
    }

    func doSignout() {
        do {
            try firebaseAuth.signOut()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window!.rootViewController = OnboardBuilder().build()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

    func isAuthenticated() -> Bool {
        return firebaseAuth.currentUser != nil
    }

    func doLogin(from view: UIViewController & FUIAuthDelegate) {
        guard let authUI = FUIAuth.defaultAuthUI() else { return }
        authUI.delegate = view
        authUI.providers = providers

        let authViewController = authUI.authViewController()
        authViewController.modalPresentationStyle = .fullScreen
        authViewController.navigationBar.topItem?.leftBarButtonItem = nil
        view.present(authViewController, animated: true, completion: nil)
    }
}
