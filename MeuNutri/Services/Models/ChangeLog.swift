//
//  ChangeLog.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 22/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation

struct ChangeLog {
    var message: String
    var author: String
    var date: Date
}

enum ChangeLogMesages: String {
    case HEALTH_DATA_DELETED, HEALTH_DATA_EXPIRED, HEALTH_DATA_SYNCED, EXPIRATION_UPDATED, SHARING_ADDED, SHARING_DELETED, HEALTH_DATA_READ

    func getMessage() -> String {
        switch self {
        case .HEALTH_DATA_DELETED:
            return "Health data deleted."
        case .HEALTH_DATA_EXPIRED:
            return "Health data deleted because it was expired."
        case .HEALTH_DATA_SYNCED:
            return "Health data synced."
        case .EXPIRATION_UPDATED:
            return "Expiration time updated."
        case .SHARING_ADDED:
            return "Added a new physician to share."
        case .SHARING_DELETED:
            return "Deleted a physician from sharing."
        case .HEALTH_DATA_READ:
            return "Health data read."
        }
    }
}
