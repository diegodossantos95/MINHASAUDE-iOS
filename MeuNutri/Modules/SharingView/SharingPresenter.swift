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

    func viewWillAppear()
}

class SharingPresenter: SharingPresenterProtocol {
    var view: (UIViewController & SharingViewProtocol)?

    func viewWillAppear() {
    }
}
