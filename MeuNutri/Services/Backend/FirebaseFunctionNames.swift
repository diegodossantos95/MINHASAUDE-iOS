//
//  FirebaseFunctionNames.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 14/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation

enum FirebaseFunctionNames: String {
    case initPatientDatabase,
         updateHealthData,
         deleteHealthData,
         getSharings,
         deleteSharing,
         addSharing,
         getExpirationAndSyncTimes,
         updateExpiration,
         getChangeLogs
}
