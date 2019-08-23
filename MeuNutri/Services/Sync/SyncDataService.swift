//
//  SyncHealthDataService.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 22/08/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation
import HealthKit

class SyncDataService {
    //MARK: Singleton
    static let shared = SyncDataService()

    //MARK: Private properties

    //MARK: Init
    private init() {
    }

    //MARK: Public functions
    func syncHealthData(completion: @escaping (Bool) -> Void) {
        //chamar função que traz os dados do healthkit convertido p/ dicionario
        //Loop no dicionario e a cada key fazer um upload
        //se algum der errado, retornar erro
        var measures: [String: [HealthMeasure]] = [:]
        let healthDataGroup = DispatchGroup()
        let uploadGroup = DispatchGroup()
        let backgroundQueue = DispatchQueue.global(qos: .background)

        // body
        healthDataGroup.enter()
        HealthDataService.shared.readHealthData(type: .bodyMass) { (samples, error) in
            if let samples = samples {
                var bodyMeasures = [HealthMeasure]()
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
            for (measure, data) in measures {
                uploadGroup.enter()
                UploadService.shared.uploadHealthData(name: measure, data: data, completion: { (error) in
                    if let error = error {
                        print(error)
                    }
                    uploadGroup.leave()
                })
            }
        }

        uploadGroup.notify(queue: .main) {
            completion(true)
        }
    }
}
