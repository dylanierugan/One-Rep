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
    
    let days: [Weekdays] = [.Sun, .Mon, .Tue, .Wed, .Thu, .Fri, .Sat]
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 32) {
            
            HStack {
                DateView()
                Spacer()
                MoveMonthButtons()
            }
            .padding(.horizontal, 8)

            HStack {
                ForEach(Weekdays.allCases, id: \.rawValue) { day in
                    Text(day.rawValue)
                        .foregroundStyle(.secondary)
                        .customFont(size: .callout, weight: .semibold, kerning: 0, design: .rounded)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach( dateViewModel.extractCurrentMonth() ) { dateObject in
                    CalendarDateButton(dateObject: dateObject)
                }
            }
        }
        .onChange(of: dateViewModel.currentMonth) { newValue, _ in
            dateViewModel.selectedDate = dateViewModel.getCurrentMonth()
        }
    }
    
}
