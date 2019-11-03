//
//  SettingsViewController.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 03/11/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

protocol SettingsViewProtocol {
    var presenter: SettingsPresenterProtocol? { get set }
}

class SettingsViewController: UITableViewController, SettingsViewProtocol {
    var presenter: SettingsPresenterProtocol?

    private let sharingIndexPath = IndexPath(row: 0, section: 0)
    private let accessLogsIndexPath = IndexPath(row: 1, section: 0)
    private let stopSharingIndexPath = IndexPath(row: 2, section: 0)
    private let signoutIndexPath = IndexPath(row: 0, section: 1)

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case sharingIndexPath:
            presenter?.sharingsDidTap()
        case accessLogsIndexPath:
            presenter?.accessLogsDidTap()
        case stopSharingIndexPath:
            presenter?.stopSharingDidTap()
        case signoutIndexPath:
            presenter?.signoutDidTap()
        default:
            break
        }
    }
}
