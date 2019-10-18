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
    func saveHealthData(name: String, data: [HealthMeasure], completion: @escaping (Error?) -> Void) {
        let mappedMeasures = data.map { $0.asDictionary }
        let mappedData = [name: mappedMeasures]

        firebaseFunctions.httpsCallable(FirebaseFunctionNames.updateHealthData.rawValue).call([healthDataCollection: mappedData]) { (result, error) in
            completion(error)
        }
    }

    func deleteHealthData(completion: @escaping (Error?) -> Void) {
        firebaseFunctions.httpsCallable(FirebaseFunctionNames.deleteHealthData.rawValue).call { (result, error) in
            completion(error)
        }
    }

    func getSharings(completion: @escaping ([String]?, Error?) -> Void) {
        firebaseFunctions.httpsCallable(FirebaseFunctionNames.getSharings.rawValue).call { (result, error) in
            if let sharings = result?.data as? [String]? {
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

    func addSharing(name: String, completion: @escaping (Error?) -> Void) {
        firebaseFunctions.httpsCallable(FirebaseFunctionNames.addSharing.rawValue).call(["sharingId": name]) { (result, error) in
            completion(error)
        }
    }

    func getExpiration(completion: @escaping (Int?, Error?) -> Void) {
        firebaseFunctions.httpsCallable(FirebaseFunctionNames.getExpiration.rawValue).call { (result, error) in
            if let days = result?.data as? Int {
                completion(days, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    func updateExpiration(date: Date, completion: @escaping (Error?) -> Void) {
        let timestamp = date.timeIntervalSince1970
        firebaseFunctions.httpsCallable(FirebaseFunctionNames.updateExpiration.rawValue).call(["expiration": timestamp]) { (result, error) in
            completion(error)
        }
    }
}
