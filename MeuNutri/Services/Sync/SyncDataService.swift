//
//  SyncHealthDataService.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 22/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation

class SyncDataService {
    //MARK: Singleton
    static let shared = SyncDataService()

    //MARK: Init
    private init() {
    }

    //MARK: Public functions
    func syncHealthData(completion: @escaping (Bool) -> Void) {
        let databaseOperationGroup = DispatchGroup()
        var success = true

        HealthDataManager.shared.readHealthData { (measures) in
            for (measure, data) in measures {
                databaseOperationGroup.enter()
                DatabaseService.shared.saveHealthData(name: measure, data: data, completion: { (error) in
                    if let _ = error {
                        success = false
                    }
                    databaseOperationGroup.leave()
                })
            }
        }

        databaseOperationGroup.notify(queue: .main) {
            completion(success)
        }
    }

    func removeHealthData(completion: @escaping (Bool) -> Void) {
        DatabaseService.shared.deleteHealthData(completion: completion)
    }
}
