//
//  HealthDataManager.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 23/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation
import HealthKit

class HealthDataManager {
    //MARK: Singleton
    static let shared = HealthDataManager()

    //MARK: Init
    private init() {
    }

    //MARK: Public functions
    func readHealthData(completion: @escaping ([String: [HealthMeasure]]) -> Void) {
        let backgroundQueue = DispatchQueue.global(qos: .background)
        var measures: [String: [HealthMeasure]] = [:]
        let healthDataGroup = DispatchGroup()

        // body
        healthDataGroup.enter()
        HealthDataService.shared.readHealthData(type: .bodyMass) { (samples, error) in
            if let samples = samples {
                var bodyMeasures = [HealthMeasure]()
                //TODO: move units to enum
                let unit = "kg"

                for data in samples {
                    let value = data.quantity.doubleValue(for: HKUnit.gram()) / 1000
                    bodyMeasures.append(HealthMeasure(unit: unit, value: value, date: data.endDate))
                }

                measures["bodyMass"] = bodyMeasures
            } else {
                //TODO
            }
            healthDataGroup.leave()
        }

        // heart rate
        healthDataGroup.enter()
        HealthDataService.shared.readHealthData(type: .heartRate) { (samples, error) in
            if let samples = samples {
                var heartRateMeasures = [HealthMeasure]()
                let unit = "BPM"

                for data in samples {
                    let value = data.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                    heartRateMeasures.append(HealthMeasure(unit: unit, value: value, date: data.endDate))
                }

                measures["heartRate"] = heartRateMeasures
            } else {
                //TODO
            }
            healthDataGroup.leave()
        }

        healthDataGroup.notify(queue: backgroundQueue) {
            completion(measures)
        }
    }
}
