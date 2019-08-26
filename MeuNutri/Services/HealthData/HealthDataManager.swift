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

        healthDataGroup.enter()
        self.readBodyMass { (bodyMeasures) in
            measures["bodyMass"] = bodyMeasures
            healthDataGroup.leave()
        }

        healthDataGroup.enter()
        self.readHeartRate { (heartRateMeasures) in
            measures["heartRate"] = heartRateMeasures
            healthDataGroup.leave()
        }

        healthDataGroup.notify(queue: backgroundQueue) {
            completion(measures)
        }
    }

    //MARK: Private functions
    private func readBodyMass(completion: @escaping ([HealthMeasure]) -> Void) {
        HealthDataService.shared.readHealthData(type: .bodyMass) { (samples, error) in
            var bodyMeasures = [HealthMeasure]()
            let unit = "kg" //TODO: move units to enum

            if let samples = samples {
                for data in samples {
                    let value = data.quantity.doubleValue(for: HKUnit.gram()) / 1000
                    bodyMeasures.append(HealthMeasure(unit: unit, value: value, date: data.endDate))
                }
            } else {
                //TODO
            }

            completion(bodyMeasures)
        }
    }

    private func readHeartRate(completion: @escaping ([HealthMeasure]) -> Void) {
        HealthDataService.shared.readHealthData(type: .heartRate) { (samples, error) in
            var heartRateMeasures = [HealthMeasure]()
            let unit = "BPM"

            if let samples = samples {
                for data in samples {
                    let value = data.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                    heartRateMeasures.append(HealthMeasure(unit: unit, value: value, date: data.endDate))
                }
            } else {
                //TODO
            }

            completion(heartRateMeasures)
        }
    }
}
