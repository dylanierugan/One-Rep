//
//  DayPicker.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/17/24.
//

import SwiftUI

struct WeekdayValue: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
    var weekday: Weekdays
}

struct DayPicker: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var dateViewModel: DateViewModel
    @EnvironmentObject var logDataController: LogDataController
    
    // MARK: - View
    
    var body: some View {
        HStack {
            ForEach(extractCurrentWeek()) { weekdayObject in
                Button(action: {
                    withAnimation {
                        dateViewModel.selectedDate = weekdayObject.date
                        dateViewModel.setDate()
                    }
                }, label: {
                    VStack {
                        Text("\(weekdayObject.day)")
                            .foregroundStyle(dateViewModel.weekday == weekdayObject.weekday ? Color(.primary) : .secondary.opacity(0.5))
                            .customFont(size: .callout, weight: .semibold, kerning: 0, design: .rounded)
                            .frame(maxWidth: .infinity)
                        Text(weekdayObject.weekday.rawValue)
                            .foregroundStyle(dateViewModel.weekday == weekdayObject.weekday ? Color(.primary) : .secondary.opacity(0.5))
                            .customFont(size: .callout, weight: .semibold, kerning: 0, design: .rounded)
                            .frame(maxWidth: .infinity)
                        if logDataController.listOfDates.contains(logDataController.formatDate(date: weekdayObject.date.timeIntervalSince1970)) {
                            Circle()
                                .fill(Color(theme.lightBaseColor))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .frame(height: 36, alignment: .top)
                })
            }
        }
    }
    
    // MARK: - Functions
    
    func getCurrentWeek() -> [Date] {
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: dateViewModel.selectedDate)!.start
        return (0...6).compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day, to: startOfWeek)!
        }
    }
    
    func extractCurrentWeek() -> [WeekdayValue] {
        let calendar = Calendar.current
        let currentWeek = getCurrentWeek()
        let days = currentWeek.compactMap { date -> WeekdayValue in
            let day = calendar.component(.day, from: date)
            let weekdayIndex = calendar.component(.weekday, from: date) - 1
            let weekday = Weekdays.allCases[weekdayIndex]
            return WeekdayValue(day: day, date: date, weekday: weekday)
        }
        return days
    }
}

// MARK: - Extension
extension Date {
    /// Function to add or subtract a week from the current date
    func move(byWeeks weeks: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .weekOfYear, value: weeks, to: self)!
    }
}