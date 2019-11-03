//
//  SettingsBuilder.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 03/11/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

class SettingsBuilder {
    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        let presenter = SettingsPresenter()

        view.presenter = presenter
        presenter.view = view

        return view
    }
}
