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
    private let readableHKCharacteristicTypes: Set<HKQuantityType> = [
        // Medidas
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!, //Peso
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMassIndex)!, //IMC
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)!, //% de gordura

        // Sinais vitais
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!, //Batimentos
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.restingHeartRate)!, //Batimentos em descanso
        HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingHeartRateAverage)!, //Batimentos em caminhada

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
