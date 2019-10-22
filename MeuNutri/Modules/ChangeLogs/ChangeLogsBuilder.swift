//
//  ChangeLogsBuilder.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 21/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

class ChangeLogsBuilder {
    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "ChangeLogs", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "ChangeLogsViewController") as! ChangeLogsViewController
        let presenter = ChangeLogsPresenter()

        view.presenter = presenter
        presenter.view = view

        return view
    }
}
