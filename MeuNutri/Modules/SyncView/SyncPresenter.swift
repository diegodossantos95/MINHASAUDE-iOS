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
    var expirationOptions: [Int: String] { get set }

    func viewWillAppear()
    func syncButtonDidTouch()
    func settingsButtonDidTouch()
    func expirationDropdownDidUpdate(value: Int)
}

class SyncPresenter: SyncPresenterProtocol {
    weak var view: (UIViewController & SyncViewProtocol)?
    var expirationOptions: [Int : String] = [
        1: "1 Day",
        7: "7 Days",
        15: "15 Days",
        30: "30 Days"
    ]

    func viewWillAppear() {
        HealthDataService.shared.requestPermission { [weak self] (success, error) in
            if let error = error {
                self?.view?.showAlertView(message: error.localizedDescription)
            }
        }
        loadExpirationTime()
    }

    func syncButtonDidTouch() {
        view?.startActivityIndicator()
        SyncDataService.shared.syncHealthData { [weak self] (date, success) in
            if !success {
                self?.view?.showAlertView(message: "Failed to sync health data")
            } else if let date = date {
                self?.view?.updateSyncLabel(text: Formatter.dateToString(date: date))
            }

            self?.view?.stopActivityIndicator()
        }
    }

    func expirationDropdownDidUpdate(value: Int) {
        BackendService.shared.updateExpiration(value: value) { (error) in
            if let error = error {
                //TODO: handle
                print(error)
            }
        }
    }

    func settingsButtonDidTouch() {
        let view = SettingsBuilder().build()
        self.view?.navigationController?.pushViewController(view, animated: true)
    }

    //Private func
    private func loadExpirationTime() {
        BackendService.shared.getExpirationAndSyncTimes{ [weak self] (expiration, sync, error) in
            if let error = error {
                //TODO: handle
                print(error)
                return
            }

            if let expiration = expiration {
                self?.view?.expirationTimeDidLoad(days: expiration)
            }

            if let sync = sync {
                self?.view?.updateSyncLabel(text: Formatter.dateToString(date: sync))
            }
        }
    }
}
