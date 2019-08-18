//
//  ViewController.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 14/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit
import FirebaseUI

protocol OnboardViewProtocol {
    var presenter: OnboardPresenterProtocol? { get set }
}

class OnboardViewController: UIViewController, OnboardViewProtocol {
    var presenter: OnboardPresenterProtocol?

    @IBAction func loginDidTouch(_ sender: UIButton) {
        presenter?.loginDidTouch()
    }
}

extension OnboardViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }

        print("handle user signup / login")
    }

    func authUI(_ authUI: FUIAuth, didFinish operation: FUIAccountSettingsOperationType, error: Error?) {
        print(operation)
    }
}
