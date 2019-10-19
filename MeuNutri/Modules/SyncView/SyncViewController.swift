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
    private var expirationValues: [String] {
        guard let values = presenter?.expirationOptions.values else {
            return []
        }
        let sorted = Array(values.sorted {$0.localizedStandardCompare($1) == .orderedAscending})
        return sorted
    }
    private var expirationIds: [Int] {
        guard let ids = presenter?.expirationOptions.keys else {
            return []
        }
        let sorted = Array(ids.sorted())
        return sorted
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lastSyncDateLabel: UILabel!
    @IBOutlet weak var expirationDropDown: DropDown!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        setupExpirationDropdown()
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
        expirationDropDown.selectedIndex = expirationIds.firstIndex(of: days) ?? 0
        expirationDropDown.text = presenter?.expirationOptions[days]
    }

    private func setupExpirationDropdown() {
        expirationDropDown.optionArray = self.expirationValues
        expirationDropDown.optionIds = self.expirationIds

        expirationDropDown.didSelect { [weak self] (text, index, id) in
            self?.presenter?.expirationDropdownDidUpdate(value: id)
        }
    }
}
