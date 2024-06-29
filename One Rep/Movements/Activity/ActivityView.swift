////
////  ActivityView.swift
////  One Rep
////
////  Created by Dylan Ierugan on 5/14/24.
////
//
//import SwiftUI
//import RealmSwift
//
//struct ActivityView: View {
//    
//    // MARK: - Variables
//    
//    @EnvironmentObject var theme: ThemeModel
//    @EnvironmentObject var logViewModel: LogViewModel
//    @EnvironmentObject var dateViewModel: DateViewModel
//    
//    @ObservedRealmObject var movementViewModel: MovementViewModel
//    @ObservedRealmObject var userModel: UserModel
//    
//    @State var showCalendar = false
//    
//    // MARK: - View
//    
//    var body: some View {
//        VStack {
//            if !showCalendar {
//                HStack {
//                    DateView()
//                    Spacer()
//                    MoveWeekButtons()
//                }
//                .padding(.top, 8)
//                .padding(.horizontal, 24)
//                DayPicker()
//                    .padding(.top, 8)
//                    .padding(.horizontal, 16)
//            } else {
//                CalendarView()
//                    .padding(.top, 8)
//                    .padding(.horizontal, 16)
//            }
//            ActivityMovementDataView(movementViewModel: movementViewModel, userModel: userModel)
//                .padding(.vertical, 16)
//                .padding(.horizontal, 16)
//        }
//        .toolbar(content: {
//            ToolbarItem(placement: .topBarTrailing) {
//                ShowCalendarButton(showCalendar: $showCalendar)
//            }
//        })
//        .onAppear() {
//            let logs = logViewModel.getAllLogs(movementViewModel.movements)
//            logViewModel.populateListOfDates(logs)
//            logViewModel.populateDateMovementLogMap(logs)
//            dateViewModel.setDate()
//        }
//    }
//}
