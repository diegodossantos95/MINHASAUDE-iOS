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

    func deleteHealthData(completion: @escaping (Bool) -> Void) {
//        firestore.collection(healthDataCollection).getDocuments { [unowned self] (query, error) in
//            guard let query = query else {
//                print(error?.localizedDescription ?? "")
//                completion(false)
//                return
//            }
//
//            let batch = self.firestore.batch()
//            for document in query.documents {
//                batch.deleteDocument(document.reference)
//            }
//
//            batch.commit(completion: { (error) in
//                completion(error == nil)
//            })
//        }
    }
}
