//
//  OnboardPresenter.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 18/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation
import FirebaseUI

protocol OnboardPresenterProtocol {
    var view: (OnboardViewProtocol & FUIAuthDelegate & UIViewController)? { get set }

    func viewDidAppear()
    func loginDidFinish()
}

class OnboardPresenter: OnboardPresenterProtocol {
    weak var view: (UIViewController & FUIAuthDelegate & OnboardViewProtocol)?

    func viewDidAppear() {
        if AuthManager.shared.isAuthenticated() {
            loginDidFinish()
        } else {
            startLoginFlow()
        }
    }

    func loginDidFinish() {
        BackendService.shared.initDatabase { (error) in
            if let error = error {
                print(error)
            }

            let syncView = SyncBuilder().build()
            self.view?.present(syncView, animated: true, completion: nil)
        }
    }

    private func startLoginFlow() {
        guard let view = view else {
            return
        }

        AuthManager.shared.doLogin(from: view)
    }
}
