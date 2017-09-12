//
//  NSDate+Extension.swift
//  ConceptOffice
//
//  Created by Denis on 02.03.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import Foundation

typealias Day = Int
typealias Week = Int
typealias Month = Int
typealias Year = Int

typealias TimeComponent = (hour: Int, minute: Int, second: Int)
typealias TimeRange = (startTime: Date, endTime: Date)
typealias DayRange = (startDay: Date, endDay: Date)

typealias MonthPeriod = (month: Month, year: Year)

extension Month {
    static var todayMonth: MonthPeriod {
        let date = Date()
        return MonthPeriod(date.month, date.year)
    }
}

enum Weekdays: Int {
    case all = 0
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

enum TimeIntervalValue: Int {
    case sec = 1
    case min = 60
    case hour = 3600
    case day = 86400
    case week = 604800

    static func interval(from timeComponent: TimeComponent) -> TimeInterval {
        var result = 0
        result += timeComponent.hour * TimeIntervalValue.hour.rawValue
        result += timeComponent.minute * TimeIntervalValue.min.rawValue
        result += timeComponent.second * TimeIntervalValue.sec.rawValue
        return TimeInterval(result)
    }
}

struct WeeksRange {
    var weeks: (start: Week, end: Week) = (0, 0)
    var years: (start: Year, end: Year) = (0, 0)
}

extension Month {
    var nextMonth: Month {
        return self == 12 ? 1 : self + 1
    }

    var previous: Month {
        return self == 1 ? 12 : self - 1
    }

    var defaultString: String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        //options: monthSymbols, shortMonthSymbols, veryShortSymbols
        let months = dateFormatter.shortMonthSymbols
        return months![self - 1]
    }
}

extension TimeInterval {
    var days: Int {
        return Int(self) / TimeIntervalValue.day.rawValue
    }
    var hours: Int {
        return Int(self) / TimeIntervalValue.hour.rawValue
    }
    var minutes: Int {
        return (Int(self)%TimeIntervalValue.hour.rawValue)/TimeIntervalValue.min.rawValue
    }
    var seconds: Int {
        return (Int(self) % TimeIntervalValue.hour.rawValue)%TimeIntervalValue.min.rawValue
    }

    var formattedTimeString: String {
        var result = ""
        if hours == 0 {
            result = "\(minutes) m"
        } else if minutes == 0 {
            result = "\(hours) h"
        } else {
            result = "\(hours) h \(minutes) m"
        }
        return result
    }
}

extension Weekdays {

    static var firstWeekday: Weekdays {
        return Weekdays(rawValue:  Date().calendar.firstWeekday)!
    }

    static var allWeekdays: [Weekdays] {
        let firstWeekday = Date().calendar.firstWeekday
        var weekdays = [Weekdays]()
        for i in firstWeekday...Weekdays.saturday.rawValue {
            weekdays.append(Weekdays(rawValue: i)!)
        }
        for i in 1..<firstWeekday {
            weekdays.append(Weekdays(rawValue: i)!)
        }
        return weekdays
    }

    var shortTitle: String {
        return  Date().calendar.veryShortWeekdaySymbols[rawValue - 1]
    }

    var defaultTitle: String {
        return  Date().calendar.shortWeekdaySymbols[rawValue - 1]
    }

    var longTitle: String {
        return  Date().calendar.weekdaySymbols[rawValue - 1]
    }

    var nextWeekday: Weekdays {
        if self == Weekdays.saturday {
            return Weekdays.sunday
        } else {
            return Weekdays(rawValue: self.rawValue + 1)!
        }
    }

    var previousWeekday: Weekdays {
        if self == Weekdays.sunday {
            return Weekdays.saturday
        } else {
            return Weekdays(rawValue: self.rawValue - 1)!
        }
    }
}

extension Date {

    fileprivate var calendar: Calendar {
        return Calendar.current
    }

    var startOfDay: Date {
        return calendar.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        let date = (calendar as NSCalendar).date(byAdding: components, to: startOfDay, options: [])!
        return date.addingTimeInterval(-1)
    }

    var weekday: Weekdays {
        let weekdayComponent = (calendar as NSCalendar).component(.weekday, from: self)
        return Weekdays(rawValue: weekdayComponent)!
    }

    var day: Day {
        return (calendar as NSCalendar).component(.day, from: self)
    }

    var month: Month {
        return (calendar as NSCalendar).component(.month, from: self)
    }

    var year: Year {
        return (calendar as NSCalendar).component(.year, from: self)
    }

    var weekOfYear: Int {
        return (calendar as NSCalendar).component(.weekOfYear, from: self)
    }

    var isInToday: Bool {
        return calendar.isDateInToday(self)
    }

    var isInYesterday: Bool {
        return calendar.isDateInYesterday(self)
    }

    var isInTomorrow: Bool {
        return calendar.isDateInTomorrow(self)
    }

    var numberOfDaysInMonth: Int {
        return (calendar as NSCalendar).range(of: .day, in: .month, for: self).length
    }

    var time: Date {
        //Date formatter
        let timeDateFormatter: DateFormatter = {
            let result = DateFormatter()
            result.dateFormat = "HH:mm:ss"
            result.timeZone = calendar.timeZone
            result.locale = Locale(identifier: "en_US_POSIX")
            return result
        }()

        let timeString = timeDateFormatter.string(from: self)
        if let time = timeDateFormatter.date(from: timeString) {
            return time
        } else {
            let components = self.timeComponent
            return timeDateFormatter.date(from: "\(components.hour):\(components.minute):\(components.second)")!
        }
    }

    var beginingOfDay: Date {
        return calendar.startOfDay(for: self).addingTimeInterval(TimeInterval(calendar.timeZone.secondsFromGMT()))
    }

    var timeComponent: TimeComponent {
        let components = calendar.dateComponents([.hour, .minute, .second], from: self)
        return TimeComponent(hour: components.hour!, minute: components.minute!, second: components.second!)
    }

    var calendarTitle: String {
        return "\(day) \(month.defaultString) \(weekday.longTitle.uppercased())"
    }

    // MARK: Methods
    static func firstDay(_ year: Year) -> Date {
        return firstDay(1, year: year)
    }

    static func lastDay(_ year: Year) -> Date {
        let firstDayInNextYear = Date.firstDay(year + 1)
        return firstDayInNextYear.addingTimeInterval(-TimeInterval(TimeIntervalValue.day.rawValue)).endOfDay
    }

    static func firstDay(_ month: Month, year: Year) -> Date {
        var firstDayComponents = DateComponents()
        firstDayComponents.year = year
        (firstDayComponents as NSDateComponents).timeZone = Date().calendar.timeZone
        firstDayComponents.weekOfYear = 1
        firstDayComponents.day = 1
        firstDayComponents.month = month
        return Date().calendar.date(from: firstDayComponents)!.startOfDay
    }

    static func lastDay(_ month: Month, year: Year) -> Date {
        var resultYear = year
        if month == 12 {
            resultYear += 1
        }
        let firstDayInNextMonth = Date.firstDay(month.nextMonth, year: resultYear)
        return firstDayInNextMonth.addingTimeInterval(-TimeInterval(TimeIntervalValue.hour.rawValue)).endOfDay
    }

    //Strings
    var defaultString: String {
        return DateFormatter.appDefaultFormatter.string(from: self)
    }

    func years(from date: Date) -> Int {
        return (calendar as NSCalendar).components(.year, from: date, to: self, options: []).year!
    }

    func months(from date: Date) -> Int {
        return (calendar as NSCalendar).components(.month, from: date, to: self, options: []).month!
    }

    func weeks(from date: Date) -> Int {
        return (calendar as NSCalendar).components(.weekOfYear, from: date, to: self, options: []).weekOfYear!
    }

    func days(from date: Date) -> Int {
        return (calendar as NSCalendar).components(.day, from: date, to: self, options: []).day!
    }

    func hours(from date: Date) -> Int {
        return (calendar as NSCalendar).components(.hour, from: date, to: self, options: []).hour!
    }

    func minutes(from date: Date) -> Int {
        return (calendar as NSCalendar).components(.minute, from: date, to: self, options: []).minute!
    }

    func seconds(from date: Date) -> Int {
        return (calendar as NSCalendar).components(.second, from: date, to: self, options: []).second!
    }

    func date(_ time: TimeComponent) -> Date {
        return self.startOfDay.addingTimeInterval(TimeIntervalValue.interval(from: time))
    }

    func isOneDay(_ anotherDate: Date) -> Bool {
        return day == anotherDate.day && month == anotherDate.month && year == anotherDate.year
    }
}

private extension Int {
    var timeValue: String {
        if self >= 10 {
            return "\(self)"
        } else {
            return "0\(self)"
        }
    }
}

enum DayPeriods: Int {
    case night = -1
    case morning = 0
    case midday = 1
    case evening = 2

    static var count = 3

    static func timeRange(for period: DayPeriods) -> TimeRange {
        var startTimeComponent: TimeComponent
        var endTimeComponent: TimeComponent
        switch period {
        case .morning:
            startTimeComponent = TimeComponent(hour: 4, minute: 0, second: 0)
            endTimeComponent = TimeComponent(hour: 11, minute: 59, second: 59)
        case .midday:
            startTimeComponent = TimeComponent(hour: 12, minute: 0, second: 0)
            endTimeComponent = TimeComponent(hour: 17, minute: 59, second: 59)
        case .evening:
            startTimeComponent = TimeComponent(hour: 18, minute: 0, second: 0)
            endTimeComponent = TimeComponent(hour: 23, minute: 59, second: 59)
        case .night:
            startTimeComponent = TimeComponent(hour: 0, minute: 0, second: 0)
            endTimeComponent = TimeComponent(hour: 3, minute: 59, second: 59)
        }

        let startTime = Date().date(startTimeComponent).time
        let endTime = Date().date(endTimeComponent).time

        return TimeRange(startTime: startTime, endTime: endTime)
    }

    var next: DayPeriods {
        let result = (rawValue + 1)%DayPeriods.count
        return DayPeriods(rawValue: result)!
    }

    var previous: DayPeriods {
        var result = rawValue - 1
        if result < -1 {
            result = 2
        }
        return DayPeriods(rawValue: result)!
    }
}

extension Date {
    var dayPeriod: DayPeriods {
        let morningRange = DayPeriods.timeRange(for: .morning)
        let middayRange = DayPeriods.timeRange(for: .midday)
        let eveningRange = DayPeriods.timeRange(for: .evening)

        if morningRange.startTime <= time && time <= morningRange.endTime {
            return .morning
        } else if middayRange.startTime <= time && time <= middayRange.endTime {
            return .midday
        } else if eveningRange.startTime <= time && time <= eveningRange.endTime {
            return .evening
        } else {
            return .night
        }
    }
}

extension Calendar {
    var is12hour: Bool {

        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .none
        formatter.timeStyle = .short

        let dateString = formatter.string(from: Date())
        var hasAMSymbol = false
        var hasPMSymbol = false
        if let amRange = dateString.range(of: formatter.amSymbol), !amRange.isEmpty {
            hasAMSymbol = true
        }

        if let pmRange = dateString.range(of: formatter.pmSymbol), !pmRange.isEmpty {
            hasPMSymbol = true
        }

        return hasPMSymbol || hasAMSymbol
    }
}
//swiftlint:disable:previous file_length
