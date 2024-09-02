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
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    
    // MARK: - Public Properties
    
    @ObservedObject var activityViewModel: ActivityViewModel
    @ObservedObject var dateViewModel: DateViewModel
    
    // MARK: - Private Properties
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 32) {
            
            HStack {
                DateView(dateViewModel: dateViewModel)
                Spacer()
                MoveMonthButtons(dateViewModel: dateViewModel)
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
                ForEach(dateViewModel.extractCurrentMonth()) { dateObject in
                    CalendarDateButton(activityViewModel: activityViewModel,
                                       dateObject: dateObject,
                                       dateViewModel: dateViewModel)
                }
            }
        }
        .onChange(of: dateViewModel.currentMonth) { newValue, _ in
            dateViewModel.selectedDate = dateViewModel.getCurrentMonth()
        }
    }
    
}
