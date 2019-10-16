//
//  SharingViewController.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 15/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

protocol SharingViewProtocol {
    var presenter: SharingPresenterProtocol? { get set }

    func sharingsDidLoad()
}

class SharingViewController: UIViewController, SharingViewProtocol {
    var presenter: SharingPresenterProtocol?
    private var sharings: [String] {
        return presenter?.sharings ?? []
    }

    @IBOutlet weak var sharingTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        sharingTableView.dataSource = self
        sharingTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    func sharingsDidLoad() {
        sharingTableView.reloadData()
    }
}

extension SharingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (action, indexPath) in
            self?.presenter?.sharingDidDelete(index: indexPath.row)
            self?.sharingTableView.deleteRows(at: [indexPath], with: .fade)
        }

         return [delete]
    }
}

extension SharingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sharingTableView.dequeueReusableCell(withIdentifier: "sharingCell")!

        cell.textLabel?.text = sharings[indexPath.row]

        return cell
    }
}
