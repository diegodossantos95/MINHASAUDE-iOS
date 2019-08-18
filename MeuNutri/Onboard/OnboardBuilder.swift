//
//  OnboardBuilder.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 18/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation
import UIKit

class OnboardBuilder {
    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Onboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "OnboardViewController") as! OnboardViewController
        let presenter = OnboardPresenter()

        view.presenter = presenter
        presenter.view = view

        return view
    }
}
