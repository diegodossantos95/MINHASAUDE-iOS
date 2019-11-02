//
//  ChangeLogsPresenter.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 21/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

protocol ChangeLogsPresenterProtocol {
    var view: (ChangeLogsViewProtocol & UIViewController)? { get set }
    var changeLogs: [ChangeLog] { get }

    func viewWillAppear()
    func formatMessageLabel(changeLog: ChangeLog) -> String
    func formatDetailLabel(changeLog: ChangeLog) -> String
}

class ChangeLogsPresenter: ChangeLogsPresenterProtocol {
    weak var view: (UIViewController & ChangeLogsViewProtocol)?
    
    var changeLogs: [ChangeLog] = []

    func viewWillAppear() {
        view?.startActivityIndicator()
        BackendService.shared.getChangeLogs { [weak self] (changelogs, error) in
            if let changelogs = changelogs {
                self?.changeLogs = changelogs.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
                self?.view?.changeLogsDidLoad()
            } else {
                //TODO: handle
                print(error)
            }
            self?.view?.stopActivityIndicator()
        }
    }

    func formatMessageLabel(changeLog: ChangeLog) -> String {
        if let messageEnum = ChangeLogMesages(rawValue: changeLog.message) {
            return messageEnum.getMessage()
        } else {
            return changeLog.message
        }
    }

    func formatDetailLabel(changeLog: ChangeLog) -> String {
        return "\(Formatter.dateToString(date: changeLog.date)) - \(changeLog.author)"
    }
}
