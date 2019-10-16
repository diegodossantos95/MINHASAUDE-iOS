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
    var sharings: [String] { get }

    func viewWillAppear()
    func sharingDidDelete(index: Int)
}

class SharingPresenter: SharingPresenterProtocol {
    var view: (UIViewController & SharingViewProtocol)?
    var sharings: [String] = []

    func viewWillAppear() {
        BackendService.shared.getSharings { [weak self] (mySharings, error) in
            if let sharings = mySharings {
                self?.sharings = sharings
                self?.view?.sharingsDidLoad()
            } else {
                print(error)
            }
        }
    }

    func sharingDidDelete(index: Int) {
        let sharing = self.sharings.remove(at: index)

        BackendService.shared.deleteSharing(name: sharing) { (error) in
            //TODO: rever the change...
            print(error)
        }
    }
}
