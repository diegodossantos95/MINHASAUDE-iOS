//
//  SharingFormPresenter.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 23/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

protocol SharingFormPresenterProtocol {
    var view: (SharingFormViewProtocol & UITableViewController)? { get set }

    func cancelButtonDidTap()
    func saveButtonDidTap()
    func cellDidTap(cell: UITableViewCell)
}

class SharingFormPresenter: SharingFormPresenterProtocol {
    weak var view: (UITableViewController & SharingFormViewProtocol)?

    private var selectedPermissions: [String] = []

    func cancelButtonDidTap() {
        view?.dismiss(animated: true, completion: nil)
    }

    func saveButtonDidTap() {
        guard let email = view?.email else {
            return
        }

        let sharing = Sharing(name: email, access: selectedPermissions)
        addSharing(sharing: sharing)
    }

    func cellDidTap(cell: UITableViewCell) {
        guard let id = cell.reuseIdentifier,
              let permission = SharingPermissions(rawValue: id) else {
            return
        }

        let isSelected = cell.accessoryType == .checkmark

        if isSelected {
            cell.accessoryType = .none
            selectedPermissions.removeAll(where: { $0 == permission.rawValue })
        } else {
            cell.accessoryType = .checkmark
            selectedPermissions.append(permission.rawValue)
        }
    }

    private func addSharing(sharing: Sharing) {
        BackendService.shared.addSharing(sharing: sharing) { [weak self] (error) in
            if error != nil {
                //TODO: handle errors
                print(error)
            } else {
                self?.view?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
