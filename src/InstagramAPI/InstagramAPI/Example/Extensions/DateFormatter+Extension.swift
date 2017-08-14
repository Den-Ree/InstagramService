//
//  NSDateFormatter+Extension.swift
//  ConceptOffice
//
//  Created by Sasha Kid on 3/26/16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import Foundation

let appDateFormatterSeparator = " "

extension DateFormatter {
    static var appDefaultFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
    static var appShortTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
    //only to transform dates
    static var appTransformDateStyleFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd\(appDateFormatterSeparator)HH:mm:ss"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
}
