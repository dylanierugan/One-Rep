//
//  ActivityView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/14/24.
//

import SwiftUI
import RealmSwift

struct ActivityView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logDataController: LogDataController
    @EnvironmentObject var dateViewModel: DateViewModel
    
    @ObservedRealmObject var movementModel: MovementViewModel
    
    @State var showCalendar = false
    
    // MARK: - View
    
    var body: some View {
        VStack {
            if !showCalendar {
                HStack {
                    DateView()
                    Spacer()
                    Button {
                        moveSelectedDate(forward: false)
                        dateViewModel.setDate()
                    } label: {
                        Image(systemName: Icons.ChevronLeft.description)
                            .font(.title2).bold()
                            .foregroundStyle(.primary)
                    }
                    Button {
                        moveSelectedDate(forward: true)
                        dateViewModel.setDate()
                    } label: {
                        Image(systemName: Icons.ChevronRight.description)
                            .font(.title2).bold()
                            .foregroundStyle(.primary)
                    }
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
            if let movementLogMap = logDataController.dateMovementLogMap[logDataController.formatDate(date: dateViewModel.selectedDate.timeIntervalSince1970)] {
                ForEach(Array(movementLogMap.keys), id: \.self) { movement in
                    VStack(alignment: .leading) {
                        Text(movement.name)
                            .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                        if let logs = movementLogMap[movement]{
                            ForEach(logs.reversed() , id: \.id) { log in
                                let weightStr = logDataController.convertWeightDoubleToString(log.weight)
                                let repStr = String(log.reps)
                                HStack {
                                    HStack {
                                        Text(weightStr)
                                            .customFont(size: .title3, weight: .semibold, kerning: 0, design: .rounded)
                                            .foregroundStyle(.primary)
                                        Text("lbs")
                                            .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                                            .foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    HStack {
                                        Text(repStr)
                                            .customFont(size: .title3, weight: .semibold, kerning: 0, design: .rounded)
                                            .foregroundStyle(.primary)
                                        Text("reps")
                                            .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                                            .foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    Text(Date(timeIntervalSince1970: log.date), style: .time)
                                        .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                                        .foregroundStyle(.primary)
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 8)
                }
            } else {
                Text("No data logged for this day")
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                    .foregroundStyle(.secondary)
                    .padding(.top, 72)
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                ShowCalendarButton(showCalendar: $showCalendar)
            }
        })
        .onAppear() {
            let logs = logDataController.getAllLogs(movementModel.movements)
            logDataController.populateListOfDates(logs)
            logDataController.populateDateMovementLogMap(logs)
            dateViewModel.setDate()
        }
    }
    
    // MARK: - Functions
    
    func moveSelectedDate(forward: Bool) {
        let weeksToMove = forward ? 1 : -1
        dateViewModel.selectedDate = dateViewModel.selectedDate.move(byWeeks: weeksToMove)
    }
}

//    ForEach(0..<logDataController.listOfDates.count, id: \.self) { index in
//        let date = logDataController.listOfDates.reversed()[index]
//        VStack {
//            Section(header: HStack {
//                Text(date)
//                    .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
//                    .foregroundColor(.primary)
//                    .padding(.horizontal, 16)
//                    .padding(.top, 16)
//                Spacer()
//            }
//            ){
//                if let movementLogMap = logDataController.dateMovementLogMap[date] {
//                    ForEach(Array(movementLogMap.keys), id: \.self) { movement in
//                        VStack(alignment: .leading) {
//                            Text(movement.name)
//                                .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
//                                .padding(.vertical, 8)
//                                .padding(.horizontal, 16)
//                            if let logs = movementLogMap[movement]{
//                                ForEach(logs.reversed() , id: \.id) { log in
//                                    let weightStr = logDataController.convertWeightDoubleToString(log.weight)
//                                    let repStr = String(log.reps)
//                                    HStack {
//                                        Text(Date(timeIntervalSince1970: log.date), style: .time)
//                                            .customFont(size: .caption, weight: .semibold, kerning: 0, design: .rounded)
//                                            .foregroundStyle(.primary)
//                                        Spacer()
//                                        HStack {
//                                            Text(weightStr)
//                                                .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
//                                                .foregroundStyle(.primary)
//                                            Text("lbs")
//                                                .customFont(size: .caption, weight: .semibold, kerning: 0, design: .rounded)
//                                                .foregroundStyle(.secondary)
//                                        }
//                                        Spacer()
//                                        HStack {
//                                            Text(repStr)
//                                                .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
//                                                .foregroundStyle(.primary)
//                                            Text("reps")
//                                                .customFont(size: .caption, weight: .semibold, kerning: 0, design: .rounded)
//                                                .foregroundStyle(.secondary)
//                                        }
//                                    }
//                                    .padding(.horizontal, 16)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            Divider().padding(.horizontal, 16)
//                .padding(.top, 16)
//        }
//    }

