//
//  ActivityView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/14/24.
//

import SwiftUI

struct ActivityView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var dateViewModel: DateViewModel
    
    // MARK: - Private Properties
    
    @State private var showCalendar = false
    
    // MARK: - View
    
    var body: some View {
        VStack {
            if !showCalendar {
                HStack {
                    DateView()
                    Spacer()
                    MoveWeekButtons()
                }
                .padding(.top, 8)
                .padding(.horizontal, 24)
                DayPicker()
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
            } else {
                CalendarView()
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
            }
            ActivityMovementDataView()
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                ShowCalendarButton(showCalendar: $showCalendar)
            }
        })
        .onAppear() {
            logViewModel.populateListOfDatesAllLogs()
            logViewModel.populateDateMovementLogMap(movements: movementsViewModel.movements)
            dateViewModel.setDate()
        }
    }
}
