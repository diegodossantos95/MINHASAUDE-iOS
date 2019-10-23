//
//  BackendService.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 21/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFunctions

class BackendService {
    //MARK: Singleton
    static let shared = BackendService()

    //MARK: Private properties
    private var firebaseFunctions: Functions
    private let healthDataCollection = "healthData"

    //MARK: Init
    private init() {
        firebaseFunctions = Functions.functions()
    }

    //MARK: Public functions
    func saveHealthData(name: String, data: [HealthMeasure], completion: @escaping (Date?, Error?) -> Void) {
        let mappedMeasures = data.map { $0.asDictionary }
        let mappedData = [name: mappedMeasures]

        firebaseFunctions.httpsCallable(FirebaseFunctionNames.updateHealthData.rawValue)
            .call([healthDataCollection: mappedData]) { (result, error) in
                if let timestamp = result?.data as? Double {
                    let date = Date(timeIntervalSince1970: timestamp)
                    completion(date, nil)
                } else {
                    completion(nil, error)
                }
            }
    }

    func initDatabase(completion: @escaping (Error?) -> Void) {
        firebaseFunctions.httpsCallable(FirebaseFunctionNames.initPatientDatabase.rawValue).call { (result, error) in
            completion(error)
        }
    }

    func deleteHealthData(completion: @escaping (Error?) -> Void) {
        firebaseFunctions.httpsCallable(FirebaseFunctionNames.deleteHealthData.rawValue).call { (result, error) in
            completion(error)
        }
    }

    func getSharings(completion: @escaping ([Sharing]?, Error?) -> Void) {
        firebaseFunctions.httpsCallable(FirebaseFunctionNames.getSharings.rawValue).call { (result, error) in
            if let data = result?.data as? [[String: Any]] {
                let sharings = data.compactMap { (sharing) -> Sharing? in
                    if let name = sharing["name"] as? String,
                        let access = sharing["access"] as? [String] {
                        return Sharing(name: name, access: access)
                    } else {
                        return nil
                    }
                }

                completion(sharings, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    func deleteSharing(name: String, completion: @escaping (Error?) -> Void) {
        firebaseFunctions.httpsCallable(FirebaseFunctionNames.deleteSharing.rawValue).call(["sharingId": name]) { (result, error) in
            completion(error)
        }
    }

    func addSharing(sharing: Sharing, completion: @escaping (Error?) -> Void) {
        firebaseFunctions.httpsCallable(FirebaseFunctionNames.addSharing.rawValue).call(["sharing": sharing.asDictionary]) { (result, error) in
            completion(error)
        }
    }

    func getExpirationAndSyncTimes(completion: @escaping (Int?, Date?, Error?) -> Void) {
        firebaseFunctions.httpsCallable(FirebaseFunctionNames.getExpirationAndSyncTimes.rawValue).call { (result, error) in
            if let data = result?.data as? [String: Any] {
                let expiration = data["expiration"] as? Int
                var syncDate: Date?

                if let sync = data["sync"] as? Double {
                    syncDate = Date(timeIntervalSince1970: sync)
                }

                completion(expiration, syncDate, nil)
            } else {
                completion(nil, nil, error)
            }
        }
    }

    func updateExpiration(value: Int, completion: @escaping (Error?) -> Void) {
        firebaseFunctions.httpsCallable(FirebaseFunctionNames.updateExpiration.rawValue).call(["expiration": value]) { (result, error) in
            completion(error)
        }
    }

    func getChangeLogs(completion: @escaping ([ChangeLog]?, Error?) -> Void) {
        firebaseFunctions.httpsCallable(FirebaseFunctionNames.getChangeLogs.rawValue).call { (result, error) in
            if let data = result?.data as? [[String: Any]] {
                let changeLogs = data.compactMap { (log) -> ChangeLog? in
                    if let message = log["message"] as? String,
                        let author = log["author"] as? String,
                        let timestamp = log["date"] as? Double {
                        return ChangeLog(message: message, author: author, date: Date(timeIntervalSince1970: timestamp))
                    } else {
                        return nil
                    }
                }

                completion(changeLogs, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
