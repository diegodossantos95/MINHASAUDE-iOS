//
//  SyncViewController.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 25/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit
import iOSDropDown

protocol SyncViewProtocol {
    var presenter: SyncPresenterProtocol? { get set }

    func startActivityIndicator()
    func stopActivityIndicator()
    func showAlertView(message: String)
    func expirationTimeDidLoad(days: Int)
}

class SyncViewController: UIViewController, SyncViewProtocol {
    var presenter: SyncPresenterProtocol?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lastSyncDateLabel: UILabel!
    @IBOutlet weak var expirationDropDown: DropDown!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()

        expirationDropDown.optionArray = ["1 Day", "7 Days", "15 Days", "30 Days"]
        expirationDropDown.optionIds = [1,7,15,30]
        expirationDropDown.didSelect { (text, index, id) in
            //TODO: call presenter and update in db
            print("\(text) - \(index) - \(id)")
        }
    }

    @IBAction func syncButtonDidTouch() {
        presenter?.syncButtonDidTouch()
    }

    @IBAction func cancelButtonDidTouch() {
        presenter?.cancelButtonDidTouch()
    }

    @IBAction func sharingsButtonDidTouch() {
        presenter?.sharingButtonDidTouch()
    }

    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }

    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    func showAlertView(message: String) {
        AlertHelper.showAlert(title: "Error", message: message, rootView: self)
    }

    func expirationTimeDidLoad(days: Int) {
        //TODO: show expiration time
        print(days)

        expirationDropDown.selectedIndex = 0
        expirationDropDown.text = "\(days) Day"


    }
}
