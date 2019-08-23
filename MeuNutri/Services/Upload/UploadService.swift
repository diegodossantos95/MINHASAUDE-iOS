//
//  UploadService.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 21/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation
import FirebaseFirestore

class UploadService {
    //MARK: Singleton
    static let shared = UploadService()

    //MARK: Private properties
    private var firestore: Firestore
    private let healthDataCollection = "healthData"

    //MARK: Init
    private init() {
        firestore = Firestore.firestore()
    }

    //MARK: Public functions
    func uploadHealthData(name: String, data: [HealthMeasure], completion: @escaping (Error?) -> Void) {
        let mappedData = data.map { $0.asDictionary }

        firestore.collection(healthDataCollection).document(name).setData(["data": mappedData], completion: completion)
    }
}
