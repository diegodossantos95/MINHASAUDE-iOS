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
}

class SyncPresenter: SyncPresenterProtocol {
    weak var view: (UIViewController & SyncViewProtocol)?

    func viewWillAppear() {
        HealthDataService.shared.requestPermission { (success, error) in
            if let error = error {
                //TODO: handle error
                print(error)
            }
        }

    }

    func syncButtonDidTouch() {
        view?.startActivityIndicator()
        SyncDataService.shared.syncHealthData { [unowned self] (success) in
            //TODO: handle error
            print("Sync worked? \(success)")
            self.view?.stopActivityIndicator()
        }
    }

    func cancelButtonDidTouch() {
        view?.startActivityIndicator()
        SyncDataService.shared.removeHealthData { (success) in
            //TODO: handle error
            print("Deletion worked? \(success)")
            self.view?.stopActivityIndicator()
        }
    }
}
