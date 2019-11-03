//
//  SettingsPresenter.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 03/11/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

protocol SettingsPresenterProtocol {
    var view: (SettingsViewProtocol & UITableViewController)? { get set }

    func sharingsDidTap()
    func accessLogsDidTap()
    func stopSharingDidTap()
    func signoutDidTap()
}

class SettingsPresenter: SettingsPresenterProtocol {
    weak var view: (UITableViewController & SettingsViewProtocol)?

    func signoutDidTap() {
        guard let view = view else {
            return
        }

        AlertHelper.showConfirmation(title: "Confirm", message: "Are you sure you want to signout?", rootView: view) {
            AuthManager.shared.doSignout()
        }
    }

    func sharingsDidTap() {
        let sharingView = SharingBuilder().build()
        self.view?.navigationController?.pushViewController(sharingView, animated: true)
    }

    func accessLogsDidTap() {
        let changeLogsView = ChangeLogsBuilder().build()
        self.view?.navigationController?.pushViewController(changeLogsView, animated: true)
    }

    func stopSharingDidTap() {
        guard let view = view else {
            return
        }

        AlertHelper.showConfirmation(title: "Confirm", message: "Are you sure you want to delete your health data from the cloud?", rootView: view) {
            SyncDataService.shared.removeHealthData { (success) in
                if !success {
                    AlertHelper.showAlert(title: "Error", message: "Failed to delete health data", rootView: view)
                }
            }
        }
    }
}
