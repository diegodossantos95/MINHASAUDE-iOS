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
    func addSharing(sharing: Sharing)
    func formatSharingCellDescription(sharing: Sharing) -> String
}

class SharingPresenter: SharingPresenterProtocol {
    weak var view: (UIViewController & SharingViewProtocol)?
    var sharings: [Sharing] = []

    func viewWillAppear() {
        BackendService.shared.getSharings { [weak self] (mySharings, error) in
            if let sharings = mySharings {
                self?.sharings = sharings
                self?.view?.sharingsDidLoad()
            } else {
                //TODO: handle errors
                print(error)
            }
        }
    }

    func deleteSharing(index: Int) {
        let sharing = self.sharings.remove(at: index)

        BackendService.shared.deleteSharing(name: sharing.name) { [weak self] (error) in
            if error != nil {
                //TODO: revert the change...
                print(error)
                self?.view?.sharingDidFailDelete()
            } else {
                self?.view?.sharingDidDelete()
            }
        }
    }

    func addSharing(sharing: Sharing) {
        BackendService.shared.addSharing(sharing: sharing) { [weak self] (error) in
            if error != nil {
                //TODO: handle errors
                print(error)
                self?.view?.sharingDidFailAdd()
            } else {
                self?.sharings.append(sharing)
                self?.view?.sharingDidAdd()
            }
        }
    }

    func formatSharingCellDescription(sharing: Sharing) -> String {
        return sharing.access.joined(separator: ", ")
    }
}
