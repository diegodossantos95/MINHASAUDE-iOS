//
//  HealthDataService.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 20/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitService {
    //MARK: Private properties
    private let healthKitDataStore: HKHealthStore?
    private let readableHKCharacteristicTypes: Set<HKQuantityType> = [HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
    // In the Apple documentation you can find every type available: https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier

    //MARK: Init
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthKitDataStore = HKHealthStore()
            healthKitDataStore?.requestAuthorization(toShare: nil,
                                                     read: readableHKCharacteristicTypes,
                                                     completion: authRequestCompletion)
        } else {
            healthKitDataStore = nil
        }
    }

    //MARK: Public functions
    func readHeartRateData() {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!

        let query = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) {
            (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in

            if let samples = samplesOrNil {
                for heartRateSamples in samples {
                    print(heartRateSamples)
                }
            } else {
                print("No heart rate sample available.")
            }
        }

        healthKitDataStore?.execute(query)
    }

    //MARK: Private functions
    private func authRequestCompletion(success: Bool, error: Error?) {
        if success {
            print("Successful authorization.")
        } else {
            print(error.debugDescription)
        }
    }
}
