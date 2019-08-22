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
    private let notAvailableError = NSError(domain: "com.diegodossantos.MeuNutri", code: 9999, userInfo: [NSLocalizedDescriptionKey: "HealthStore not available"])
    private let healthKitDataStore: HKHealthStore?
    private let readableHKCharacteristicTypes: Set<HKQuantityType> = [
        // Medidas
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!, //Peso
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMassIndex)!, //IMC
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)!, //% de gordura

        // Sinais vitais
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!, //Batimentos

        // Nutrição
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCarbohydrates)!, //Carboidratos
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCholesterol)!, //Colesterol Alimentar
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!, //Energia Alimentar
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFatSaturated)!, //Gordura Saturada
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFatTotal)!, //Gordura Total
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFiber)!, //Fibra
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryProtein)!, //Proteina
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySodium)!, //Sodio
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySugar)!, //Acucar
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater)!, //Agua

        // Atividade
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!, //Energia ativa
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!, //Minutos de exercicio
    ]
    // In the Apple documentation you can find every type available: https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier

    //MARK: Init
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthKitDataStore = HKHealthStore()
        } else {
            healthKitDataStore = nil
        }
    }

    //MARK: Public functions
    func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        guard let _ = healthKitDataStore else {
            completion(false, notAvailableError)
            return
        }

        healthKitDataStore?.requestAuthorization(toShare: nil,
                                                 read: readableHKCharacteristicTypes,
                                                 completion: completion)
    }

    func readHealthData(type: HKQuantityTypeIdentifier, completionHandler: @escaping ([HKSample]?, Error?) -> Void) {
        guard let _ = healthKitDataStore,
            let healthDataType = HKQuantityType.quantityType(forIdentifier: type) else {
                completionHandler(nil, notAvailableError)
                return
        }

        let query = HKAnchoredObjectQuery(type: healthDataType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) {
            (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
            completionHandler(samplesOrNil, errorOrNil)
        }


        healthKitDataStore?.execute(query)
    }
}

/*
let now = Date()
let exactlySevenDaysAgo = Calendar.current.date(byAdding: DateComponents(day: -7), to: now)!
let startOfSevenDaysAgo = Calendar.current.startOfDay(for: exactlySevenDaysAgo)
let predicate = HKQuery.predicateForSamples(withStart: startOfSevenDaysAgo, end: now, options: .strictStartDate)
let query = HKStatisticsCollectionQuery.init(quantityType: healthDataType,
                                             quantitySamplePredicate: predicate,
                                             options: .cumulativeSum,
                                             anchorDate: startOfSevenDaysAgo,
                                             intervalComponents: DateComponents(day: 1))
query.initialResultsHandler = { query, results, error in
    guard let statsCollection = results else {
        // Perform proper error handling here...
        return
    }

    statsCollection.enumerateStatistics(from: startOfSevenDaysAgo, to: now) { statistics, stop in

        if let quantity = statistics.sumQuantity() {
            let stepValue = quantity.doubleValue(for: HKUnit.count())
            // ...
        }
    }
}*/
