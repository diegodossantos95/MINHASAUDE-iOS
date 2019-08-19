//
//  ViewController.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 14/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit
import FirebaseUI
import FirebaseFunctions

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
        }

        print("handle user signup / login")


        //Code used to call function
        var functions = Functions.functions()
        functions.httpsCallable("mobileAPI").call() { (result, error) in
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    let code = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                }
            }
            if let data = result?.data {
                print(data)
            }
        }
    }
}
