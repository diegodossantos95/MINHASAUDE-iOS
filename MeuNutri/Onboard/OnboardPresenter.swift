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
}

class OnboardPresenter: OnboardPresenterProtocol {
    weak var view: (UIViewController & FUIAuthDelegate & OnboardViewProtocol)?
    private let providers: [FUIAuthProvider] = [
        FUIEmailAuth()
    ]

    func viewDidAppear() {
//        startLoginFlow()

//        let service = HealthKitService()
//        service.requestPermission { (success, error) in
//            service.readHealthData(type: .appleExerciseTime) { (samples, error) in
//                if let samples = samples {
//                    print(samples)
//                } else {
//                    print(error)
//                }
//            }
//        }

        UploadService.shared.upload()

    }

    private func startLoginFlow() {
        guard let authUI = FUIAuth.defaultAuthUI() else { return }
        authUI.delegate = view
        authUI.providers = providers

        let authViewController = authUI.authViewController()
        view?.present(authViewController, animated: true, completion: nil)
    }
}
