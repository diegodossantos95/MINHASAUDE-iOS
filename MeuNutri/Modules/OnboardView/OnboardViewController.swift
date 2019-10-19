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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
}

extension OnboardViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        } else {
            presenter?.loginDidFinish()
        }
    }
}
