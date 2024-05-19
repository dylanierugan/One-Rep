//
//  CalendarView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/16/24.
//

import SwiftUI

struct DateValue: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
}

struct CalendarView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var dateViewModel: DateViewModel
    
    @State var currentMonth: Int = 0
    
    let days: [Weekdays] = [.Sun, .Mon, .Tue, .Wed, .Thu, .Fri, .Sat]
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 32) {
            HStack {
                DateView()
                Spacer()
                Button {
                    withAnimation {
                        currentMonth -= 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                            dateViewModel.setMonth()
                            dateViewModel.setYear()
                        }
                    }
                } label: {
                    Image(systemName: Icons.ChevronLeft.description)
                        .font(.title2).bold()
                        .foregroundStyle(.primary)
                }
                Button {
                    withAnimation {
                        currentMonth += 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                            dateViewModel.setMonth()
                            dateViewModel.setYear()
                        }
                    }
                } label: {
                    Image(systemName: Icons.ChevronRight.description)
                        .font(.title2).bold()
                        .foregroundStyle(.primary)
                }
            }
            .padding(.horizontal, 8)

            /// Days
            HStack {
                ForEach(Weekdays.allCases, id: \.rawValue) { day in
                    Text(day.rawValue)
                        .foregroundStyle(.secondary)
                        .customFont(size: .callout, weight: .semibold, kerning: 0, design: .rounded)
                        .frame(maxWidth: .infinity)
                }
            }
            
            /// Dates
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach( extractCurrentMonth() ) { dateObject in
                    CalendarDateButton(dateObject: dateObject, isSameDay: isSameDay)
                }
            }
        }
        .onChange(of: currentMonth) { newValue, _ in
            dateViewModel.selectedDate = getCurrentMonth()
        }
    }
    
    // MARK: - Functions
    
    func isSameDay(dateOne: Double, dateTwo: Double) -> Bool {
        let date1 = Date(timeIntervalSince1970: dateOne)
        let date2 = Date(timeIntervalSince1970: dateTwo)
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
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
}

// MARK: - Extension
extension Date {
    /// Function to get all dates in the current month
    func getAllDatesInMonth() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
