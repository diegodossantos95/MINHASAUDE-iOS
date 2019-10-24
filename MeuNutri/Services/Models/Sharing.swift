//
//  Sharing.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 23/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation

struct Sharing {
    var name: String
    var access: [String]

    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
            guard label != nil else { return nil }
            return (label!, value)
        }).compactMap{ $0 })
        return dict
    }
}

enum SharingPermissions: String {
    case bodyMass, heartRate

    func getText() -> String {
        switch self {
        case .bodyMass:
            return "Body Mass"
        case .heartRate:
            return "Heart Rate"
        }
    }
}
