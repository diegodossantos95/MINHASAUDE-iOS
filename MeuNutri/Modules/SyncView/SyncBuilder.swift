//
//  SyncBuilder.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 25/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation
import UIKit

class SyncBuilder {
    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Sync", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SyncViewController") as! SyncViewController
        let presenter = SyncPresenter()

        view.presenter = presenter
        presenter.view = view

        return view
    }
}
