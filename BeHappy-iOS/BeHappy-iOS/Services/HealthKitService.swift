//
//  HealthKitService.swift
//  BeHappy-iOS
//
//  Created by Reno Muijsenberg on 10/03/2023.
//

import Foundation
import HealthKit


class HealthKitService {
    let healthStore = HKHealthStore()

    func checkHealthKitConnection(completion: @escaping (Bool) -> Void) {
        if HKHealthStore.isHealthDataAvailable() {
            let healthKitTypes: Set = [
                HKObjectType.quantityType(forIdentifier: .heartRate)!,
                HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
            ]
            healthStore.requestAuthorization(toShare: nil, read: healthKitTypes) {(success, error) in
                if success {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        } else {
            completion(false)
        }
    }

    func startHeartRateQuery(completion: @escaping (Double) -> Void) {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }
        let query = HKObserverQuery(sampleType: heartRateType, predicate: nil) { (query, completionHandler, error) in
            if let error = error {
                print("Error receiving heart rate updates: \(error.localizedDescription)")
                return
            }
            self.fetchLatestHeartRate(completion: { (heartRate) in
                completion(heartRate)
            })
        }
        healthStore.execute(query)
    }
    
    func fetchLatestHeartRate(completion: @escaping (Double) -> Void) {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }
        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard error == nil, let samples = samples as? [HKQuantitySample] else { return }
            let mostRecentSample = samples.max(by: { $0.endDate < $1.endDate })
            if let heartRate = mostRecentSample?.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute())) {
                completion(heartRate)
            }
        }
        healthStore.execute(query)
    }
    
    func startHRVQuery(completion: @escaping (Double) -> Void) {
        guard let hrvType = HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN) else { return }
        let query = HKObserverQuery(sampleType: hrvType, predicate: nil) { (query, completionHandler, error) in
            if let error = error {
                print("Error receiving HRV updates: \(error.localizedDescription)")
                return
            }
            self.fetchLatestHRV(completion: { (hrv) in
                completion(hrv)
            })
        }
        healthStore.execute(query)
    }
    
    func fetchLatestHRV(completion: @escaping (Double) -> Void) {
        guard let hrvType = HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN) else { return }
        let query = HKSampleQuery(sampleType: hrvType,
                                  predicate: nil,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: nil) { (query, samples, error) in
            guard error == nil, let samples = samples as? [HKQuantitySample] else { return }
            let mostRecentSample = samples.max(by: { $0.endDate < $1.endDate })
            if let hrv = mostRecentSample?.quantity.doubleValue(for: HKUnit.secondUnit(with: .milli)) {
                completion(hrv)
            }
        }
        healthStore.execute(query)
    }
}
