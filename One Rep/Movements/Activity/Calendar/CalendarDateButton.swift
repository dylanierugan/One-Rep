//
//  CalendarDateButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/16/24.
//

import SwiftUI

struct CalendarDateButton: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logDataController: LogDataController
    @EnvironmentObject var dateViewModel: DateViewModel
    
    @State var dateObject: DateValue
    
    var computedDate: String {
        return logDataController.formatDate(date: dateObject.date.timeIntervalSince1970)
    }
    
    // MARK: - View
    
    var body: some View {
        Button {
            dateViewModel.selectedDate = dateObject.date
            dateViewModel.setDate()
            HapticManager.instance.impact(style: .soft)
        } label: {
            VStack {
                if dateObject.day != -1 {
                    if logDataController.listOfDates.contains(computedDate) {
                        VStack {
                            Text("\(dateObject.day)")
                                .font(.title3.bold())
                                .foregroundStyle(dateViewModel.isSameDay(dateOne: dateObject.date.timeIntervalSince1970, dateTwo: dateViewModel.selectedDate.timeIntervalSince1970) ? .black : .primary)
                                .frame(maxWidth: .infinity)
                            Spacer()
                            Circle()
                                .fill(dateViewModel.isSameDay(dateOne: dateObject.date.timeIntervalSince1970, dateTwo: dateViewModel.selectedDate.timeIntervalSince1970) ? .white : Color(theme.lightBaseColor))
                                .frame(width: 8, height: 8)
                        }
                    } else {
                        VStack {
                            Text("\(dateObject.day)")
                                .font(.title3.bold())
                                .foregroundColor(dateViewModel.isSameDay(dateOne: dateObject.date.timeIntervalSince1970, dateTwo: dateViewModel.selectedDate.timeIntervalSince1970) ? .black : .primary)
                                .frame(maxWidth: .infinity)
                            Spacer()
                        }
                    }
                }
            }
            .padding(.vertical, 8)
            .frame(height: 56, alignment: .top)
        }
        .background(
            Capsule()
                .fill(.linearGradient(colors: [
                    Color(theme.lightBaseColor),
                    Color(theme.darkBaseColor)
                ], startPoint: .top, endPoint: .bottom))
                .padding(.horizontal, 8)
                .opacity(dateViewModel.isSameDay(dateOne: dateObject.date.timeIntervalSince1970, dateTwo: dateViewModel.selectedDate.timeIntervalSince1970) ? 1 : 0)
        )
    }
}
