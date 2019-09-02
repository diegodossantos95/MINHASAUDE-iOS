//
//  UploadService.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 21/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    //MARK: Singleton
    static let shared = DatabaseService()

    //MARK: Private properties
    private var firestore: Firestore
    private let healthDataCollection = "healthData"

    //MARK: Init
    private init() {
        firestore = Firestore.firestore()
    }

    //MARK: Public functions
    func saveHealthData(name: String, data: [HealthMeasure], completion: @escaping (Error?) -> Void) {
        let mappedData = data.map { $0.asDictionary }

        firestore.collection(healthDataCollection).document(name).setData(["data": mappedData], completion: completion)
    }

    func deleteHealthData(completion: @escaping (Bool) -> Void) {
        firestore.collection(healthDataCollection).getDocuments { [unowned self] (query, error) in
            guard let query = query else {
                print(error?.localizedDescription ?? "")
                completion(false)
                return
            }

            let batch = self.firestore.batch()
            for document in query.documents {
                batch.deleteDocument(document.reference)
            }

            batch.commit(completion: { (error) in
                completion(error == nil)
            })
        }
    }
}
