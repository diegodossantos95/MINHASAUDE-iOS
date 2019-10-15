//
//  SharingViewController.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 15/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

protocol SharingViewProtocol {
    var presenter: SharingPresenterProtocol? { get set }
}

class SharingViewController: UIViewController, SharingViewProtocol {
    var presenter: SharingPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
