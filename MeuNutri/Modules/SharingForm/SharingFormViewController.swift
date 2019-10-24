//
//  SharingFormViewController.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 23/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

protocol SharingFormViewProtocol {
    var presenter: SharingFormPresenterProtocol? { get set }
    var email: String { get }
}

class SharingFormViewController: UITableViewController, SharingFormViewProtocol {
    var presenter: SharingFormPresenterProtocol?
    var email: String {
        return emailTextField.text ?? ""
    }
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationItem.title = "New Sharing"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonDidTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonDidTap))
    }

    @objc
    private func cancelButtonDidTap() {
        presenter?.cancelButtonDidTap()
    }

    @objc
    private func saveButtonDidTap() {
        presenter?.saveButtonDidTap()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            presenter?.cellDidTap(cell: cell)
        }
    }
}
