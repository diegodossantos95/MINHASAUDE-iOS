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
    func cancelButtonDidTouch()
    func sharingButtonDidTouch()
    func signoutButtonDidTouch()
    func expirationDropdownDidUpdate(value: Int)
    func changeLogsButtonDidTouch()
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

    func cancelButtonDidTouch() {
        guard let view = view else {
            return
        }

        AlertHelper.showConfirmation(title: "Confirm", message: "Are you sure you want to delete your health data from the cloud?", rootView: view) { [weak self] in
            self?.view?.startActivityIndicator()
            SyncDataService.shared.removeHealthData { [weak self] (success) in
                if !success {
                    self?.view?.showAlertView(message: "Failed to delete health data")
                }
                self?.view?.stopActivityIndicator()
            }

        }
    }

    func sharingButtonDidTouch() {
        let sharingView = SharingBuilder().build()
        self.view?.navigationController?.pushViewController(sharingView, animated: true)
    }

    func expirationDropdownDidUpdate(value: Int) {
        BackendService.shared.updateExpiration(value: value) { (error) in
            if let error = error {
                //TODO: handle
                print(error)
            }
        }
    }

    func signoutButtonDidTouch() {
        guard let view = view else {
            return
        }

        AlertHelper.showConfirmation(title: "Confirm", message: "Are you sure you want to signout?", rootView: view) { [weak self] in
            AuthManager.shared.doSignout()
        }
    }

    func changeLogsButtonDidTouch() {
        let changeLogsView = ChangeLogsBuilder().build()
        self.view?.navigationController?.pushViewController(changeLogsView, animated: true)
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
