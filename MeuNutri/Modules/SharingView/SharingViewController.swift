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
    func sharingDidDelete()
    func sharingDidFailDelete()
    func sharingDidAdd()
    func sharingDidFailAdd()
}

class SharingViewController: UIViewController, SharingViewProtocol {
    var presenter: SharingPresenterProtocol?
    private var sharings: [Sharing] {
        return presenter?.sharings ?? []
    }

    @IBOutlet weak var sharingTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupAddButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()

        //TODO: add loading indicator
    }

    func sharingsDidLoad() {
        sharingTableView.reloadData()
    }

    func sharingDidDelete() {
        sharingTableView.reloadData()
    }

    func sharingDidFailDelete() {
        //TODO
    }

    func sharingDidAdd() {
        sharingTableView.reloadData()
    }

    func sharingDidFailAdd() {
        //TODO
    }

    // Private funcs
    private func setupTableView() {
        sharingTableView.dataSource = self
        sharingTableView.delegate = self
    }

    private func setupAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonDidTap))
    }

    @objc
    private func addButtonDidTap() {
        let alert = UIAlertController(title: "New Sharing", message: "Input the physician's email to share your health data.", preferredStyle:
            .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Email"
        }

        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] (action) in
            guard let text = alert.textFields?[0].text else {
                return
            }

            //TODO: get the access from a form
            let sharing = Sharing(name: text, access: ["bodyMass"])

            self?.presenter?.addSharing(sharing: sharing)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))

        self.present(alert, animated: true, completion: nil)
    }
}

extension SharingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (action, indexPath) in
            self?.presenter?.deleteSharing(index: indexPath.row)
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
        let sharing = sharings[indexPath.row]

        cell.textLabel?.text = sharing.name
        cell.detailTextLabel?.text = presenter?.formatSharingCellDescription(sharing: sharing)

        return cell
    }
}
