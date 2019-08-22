//
//  UploadService.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 21/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation
import FirebaseFunctions
import FirebaseFirestore

class UploadService {
    //MARK: Singleton
    static let shared = UploadService()

    //MARK: Private properties
    private var functions: Functions

    //MARK: Init
    private init() {
        functions = Functions.functions()
        functions.useFunctionsEmulator(origin: "http://localhost:5001")
    }

    func upload() {
        let data = [
            HealthMeasure(unit: "kg", value: 60, date: Date.init(timeIntervalSinceNow: 1)).asDictionary,
            HealthMeasure(unit: "kg", value: 80, date: Date.init(timeIntervalSinceNow: 999999)).asDictionary
        ]

        Firestore.firestore().collection("healthData").document("weight").setData(["data": data]) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
}
