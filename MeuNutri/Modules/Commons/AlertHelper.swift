//
//  AlertHelper.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 16/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

class AlertHelper {
    static func showAlert(title: String, message: String, rootView: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        rootView.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            alert.dismiss(animated: true)
        }
    }
}
