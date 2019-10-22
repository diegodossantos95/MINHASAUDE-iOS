//
//  ChangeLogsViewController.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 21/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

protocol ChangeLogsViewProtocol {
    var presenter: ChangeLogsPresenterProtocol? { get set }

    func changeLogsDidLoad()
}

class ChangeLogsViewController: UIViewController, ChangeLogsViewProtocol {
    var presenter: ChangeLogsPresenterProtocol?
    private var changeLogs: [ChangeLog] {
        return presenter?.changeLogs ?? []
    }

    @IBOutlet weak var changeLogsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    func changeLogsDidLoad() {
        changeLogsTableView.reloadData()
    }

    // Private funcs
    private func setupTableView() {
        changeLogsTableView.dataSource = self
    }
}

extension ChangeLogsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return changeLogs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "changeLogCell")!
        let changeLog = changeLogs[indexPath.row]

        cell.textLabel?.text = presenter?.formatMessageLabel(changeLog: changeLog)
        cell.detailTextLabel?.text = presenter?.formatDetailLabel(changeLog: changeLog)

        return cell
    }
}
