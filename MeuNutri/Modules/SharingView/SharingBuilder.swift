//
//  SharingBuilder.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 15/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

class SharingBuilder {
    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Sharing", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SharingViewController") as! SharingViewController
        let presenter = SharingPresenter()

        view.presenter = presenter
        presenter.view = view

        return view
    }
}
