//
//  DateViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/18/24.
//

import Foundation

import Foundation
import RealmSwift

class DateViewModel: ObservableObject {
    
    @Published var selectedDate: Date = Date.now
    @Published var day: String = ""
    @Published var month = ""
    @Published var year = ""
    @Published var weekday: Weekdays = .Mon
    @Published var currentMonth: Int = 0
    
    func setWeekday() {
        let weekdayInt = Calendar.current.component(.weekday, from: selectedDate)
        weekday = Weekdays.allCases[weekdayInt - 1]
    }
    
    func setDay() {
        let calendar = Calendar.current
        let dayInt = calendar.component(.day, from: selectedDate)
        day = String(dayInt)
    }
    
    func setMonth() {
        let calendar = Calendar.current
        let monthInt = calendar.component(.month, from: selectedDate) - 1
        month = calendar.monthSymbols[monthInt]
    }
    
    func setYear() {
        let calendar = Calendar.current
        year = String(calendar.component(.year, from: selectedDate))
    }
    
    func moveSelectedDate(forward: Bool) {
        let weeksToMove = forward ? 1 : -1
        selectedDate = selectedDate.move(byWeeks: weeksToMove)
    }
    
    func isSameDay(dateOne: Double, dateTwo: Double) -> Bool {
        let date1 = Date(timeIntervalSince1970: dateOne)
        let date2 = Date(timeIntervalSince1970: dateTwo)
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    func extractCurrentMonth() -> [DateValue] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDatesInMonth().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        let firstWeekday = calendar.component(.weekday, from: days.first!.date)
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
    
    func formattedSelectedDate() -> String {
        let calendar = Calendar.current
        let today = Date()
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        
        if calendar.isDate(selectedDate, inSameDayAs: today) {
            return "Today,  \(dateFormatter.string(from: selectedDate))"
        } else if calendar.isDate(selectedDate, inSameDayAs: yesterday) {
            return "Yesterday,  \(dateFormatter.string(from: selectedDate))"
        } else if calendar.isDate(selectedDate, inSameDayAs: tomorrow) {
            return "Tomorrow,  \(dateFormatter.string(from: selectedDate))"
        } else {
            return dateFormatter.string(from: selectedDate)
        }
    }
    
    func setDate() {
        self.setWeekday()
        self.setDay()
        self.setMonth()
        self.setYear()
    }
}

// MARK: - Extension
extension Date {
    
    func move(byWeeks weeks: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .weekOfYear, value: weeks, to: self)!
    }
    
    func getAllDatesInMonth() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
    
}
