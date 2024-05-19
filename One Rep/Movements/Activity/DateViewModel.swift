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
    
    func setDate() {
        self.setWeekday()
        self.setDay()
        self.setMonth()
        self.setYear()
    }
    
}
