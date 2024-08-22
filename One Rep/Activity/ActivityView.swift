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
    @EnvironmentObject var logsViewModel: LogsViewModel
    
    // MARK: - Private Properties
    
    @StateObject private var dateViewModel = DateViewModel()
    @State private var showCalendar = false
    
    // MARK: - View
    
    var body: some View {
        VStack {
            if !showCalendar {
                HStack {
                    DateView(dateViewModel: dateViewModel)
                    Spacer()
                    MoveWeekButtons(dateViewModel: dateViewModel)
                }
                .padding(.top, 8)
                .padding(.horizontal, 24)
                DayPicker(dateViewModel: dateViewModel)
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
            } else {
                CalendarView(dateViewModel: dateViewModel)
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
            }
            ActivityMovementDataView(dateViewModel: dateViewModel)
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                ShowCalendarButton(showCalendar: $showCalendar)
            }
        })
        .onAppear {
            logsViewModel.populateListOfDatesAllLogs()
            logsViewModel.populateDateMovementLogMap(movements: movementsViewModel.movements)
            dateViewModel.setDate()
        }
    }
}
