//
//  HealthMeasure.swift
//  
//
//  Created by dos Santos, Diego on 21/08/19.
//

import Foundation
import FirebaseFirestore

struct HealthMeasure {
    var unit: String
    var value: Double
    var date: Date

    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
            guard label != nil else { return nil }

            if let dateValue = value as? Date {
                let timestamp = dateValue.timeIntervalSince1970
                return (label!, timestamp)
            }

            return (label!, value)
        }).compactMap{ $0 })
        return dict
    }
}
