//
//  SyncViewController.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 25/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

protocol SyncViewProtocol {
    var presenter: SyncPresenterProtocol? { get set }

    func startActivityIndicator()
    func stopActivityIndicator()
}

class SyncViewController: UIViewController, SyncViewProtocol {
    var presenter: SyncPresenterProtocol?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    @IBAction func syncButtonDidTouch() {
        presenter?.syncButtonDidTouch()
    }

    @IBAction func cancelButtonDidTouch() {
        presenter?.cancelButtonDidTouch()
    }

    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }

    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}
