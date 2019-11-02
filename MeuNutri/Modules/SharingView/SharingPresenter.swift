//
//  SharingPresenter.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 15/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

protocol SharingPresenterProtocol {
    var view: (SharingViewProtocol & UIViewController)? { get set }
    var sharings: [Sharing] { get }

    func viewWillAppear()
    func deleteSharing(index: Int)
    func formatSharingCellDescription(sharing: Sharing) -> String
}

class SharingPresenter: SharingPresenterProtocol {
    weak var view: (UIViewController & SharingViewProtocol)?
    var sharings: [Sharing] = []

    func viewWillAppear() {
        view?.startActivityIndicator()
        BackendService.shared.getSharings { [weak self] (mySharings, error) in
            if let sharings = mySharings {
                self?.sharings = sharings
                self?.view?.sharingsDidLoad()
            } else {
                //TODO: handle errors
                print(error)
            }
            self?.view?.stopActivityIndicator()
        }
    }

    func deleteSharing(index: Int) {
        let sharing = self.sharings.remove(at: index)
        view?.startActivityIndicator()

        BackendService.shared.deleteSharing(name: sharing.name) { [weak self] (error) in
            if error != nil {
                //TODO: revert the change...
                print(error)
                self?.view?.sharingDidFailDelete()
            } else {
                self?.view?.sharingDidDelete()
            }
            self?.view?.stopActivityIndicator()
        }
    }

    func formatSharingCellDescription(sharing: Sharing) -> String {
        let permissions = sharing.access.compactMap { (value) -> String? in
            if let permission = SharingPermissions(rawValue: value) {
                return permission.getText()
            } else {
                return nil
            }
        }

        return "Permission: \(permissions.joined(separator: ", "))" 
    }
}
