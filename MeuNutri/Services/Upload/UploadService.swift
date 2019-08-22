//
//  UploadService.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 21/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation
import FirebaseFunctions

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
        functions.httpsCallable("mobileAPI").call(["text": "OLAR"]) { (result, error) in
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    let code = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                }
            }
            if let text = (result?.data as? [String: Any])?["olar"] as? String {
                print(text)
            }
        }
    }
}
