//
//  String+Extensions.swift
//  ConceptOffice
//
//  Created by Denis on 21.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import Foundation
import UIKit

extension String {
    //TODO: Make String.App. enum
    static var emptyString: String {
        return ""
    }

    static var noValue: String {
        return "-"
    }

    static var spaceString: String {
        return " "
    }

    static var newLineString: String {
        return "\n"
    }

    static var dotString: String {
        return "."
    }

    static var rightArrowString: String {
        return " >"
    }

    static var quoteString: String {
        return "\""
    }

    static var hashtagString: String {
        return "#"
    }

    static var accountString: String {
        return "@"
    }

    static var colon: String {
        return ":"
    }

    static var hiddenSymbol: String {
        return "⠀"
    }

    var localize: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

extension String {

    func underlineSubstring(_ substring: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        let result = NSMutableAttributedString(string: self)
        let underlineRange = (self as NSString).range(of: substring)
        //swiftlint:disable:next legacy_constructor line_length
        result.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleNone.rawValue, range: NSMakeRange(0, characters.count))
        //swiftlint:disable:next line_length
        result.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: underlineRange)
        //swiftlint:disable:next legacy_constructor line_length
        result.addAttributes([NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: color], range: NSMakeRange(0, characters.count))

        return result
    }

    var hashtagsSubstrings: [String] {
        return matches(for: "((?:#){1}[\\w\\d]{1,140})")
    }

    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
