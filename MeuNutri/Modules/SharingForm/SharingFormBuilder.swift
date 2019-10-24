//
//  SharingFormBuilder.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 23/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

class SharingFormBuilder {
    func build() -> UINavigationController {
        let storyboard = UIStoryboard(name: "SharingFormViewController", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SharingFormViewController") as! SharingFormViewController
        let presenter = SharingFormPresenter()
        let navigationController = UINavigationController(rootViewController: view)

        navigationController.modalPresentationStyle = .fullScreen
        view.presenter = presenter
        presenter.view = view

        return navigationController
    }
}
