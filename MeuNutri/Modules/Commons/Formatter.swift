//
//  DateFormatter.swift
//  MeuNutri
//
//  Created by dos Santos, Diego on 18/10/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation

class Formatter {
    static func dateToString(date: Date) -> String {
        if #available(iOS 13.0, *) {
            let currentDate = Date()
            let formatter = RelativeDateTimeFormatter()
            return formatter.localizedString(for: date, relativeTo: currentDate)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            return dateFormatter.string(from: date)
        }
    }
}
