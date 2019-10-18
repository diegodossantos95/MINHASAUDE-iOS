//
//  SyncPresenter.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 25/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

protocol SyncPresenterProtocol {
    var view: (SyncViewProtocol & UIViewController)? { get set }

    func viewWillAppear()
    func syncButtonDidTouch()
    func cancelButtonDidTouch()
    func sharingButtonDidTouch()
}

class SyncPresenter: SyncPresenterProtocol {
    weak var view: (UIViewController & SyncViewProtocol)?

    func viewWillAppear() {
        HealthDataService.shared.requestPermission { (success, error) in
            if let error = error {
                self.view?.showAlertView(message: error.localizedDescription)
            }
        }
        loadExpirationTime()
    }

    func syncButtonDidTouch() {
        view?.startActivityIndicator()
        SyncDataService.shared.syncHealthData { [unowned self] (success) in
            if !success {
                self.view?.showAlertView(message: "Failed to sync health data")
            }
            self.view?.stopActivityIndicator()
        }
    }

    func cancelButtonDidTouch() {
        view?.startActivityIndicator()
        SyncDataService.shared.removeHealthData { (success) in
            if !success {
                self.view?.showAlertView(message: "Failed to delete health data")
            }
            self.view?.stopActivityIndicator()
        }
    }

    func sharingButtonDidTouch() {
        let sharingView = SharingBuilder().build()
        self.view?.navigationController?.pushViewController(sharingView, animated: true)
    }

    //Private func
    private func loadExpirationTime() {
        BackendService.shared.getExpiration { (days, error) in
            if let error =  error {
                //TODO: handle
                print(error)
            } else if let days = days {
                self.view?.expirationTimeDidLoad(days: days)
            }
        }
    }
}
