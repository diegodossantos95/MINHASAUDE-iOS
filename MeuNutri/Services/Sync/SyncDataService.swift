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
    func syncHealthData(completion: @escaping (Date?, Bool) -> Void) {
        let databaseOperationGroup = DispatchGroup()
        var success = true
        var syncDate: Date?

        databaseOperationGroup.enter()
        HealthDataManager.shared.readHealthData { (measures) in
            for (measure, data) in measures {
                databaseOperationGroup.enter()
                BackendService.shared.saveHealthData(name: measure, data: data, completion: { (date, error)  in
                    if let error = error {
                        print(error)
                        success = false
                    }

                    syncDate = date
                    databaseOperationGroup.leave()
                })
            }
            databaseOperationGroup.leave()
        }

        databaseOperationGroup.notify(queue: .main) {
            completion(syncDate, success)
        }
    }

    func removeHealthData(completion: @escaping (Bool) -> Void) {
        BackendService.shared.deleteHealthData { (error) in
            if let error = error {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
