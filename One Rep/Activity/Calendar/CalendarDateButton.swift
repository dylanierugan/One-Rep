//
//  CalendarDateButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/16/24.
//

import SwiftUI

struct CalendarDateButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var dateViewModel: DateViewModel
    
    // MARK: - Public Properties
    
    @State var dateObject: DateValue
    
    // MARK: - Private Properties
    
    private var computedDate: String {
        return logViewModel.formatDate(date: dateObject.date.timeIntervalSince1970)
    }
    
    // MARK: - View
    
    var body: some View {
        Button {
            withAnimation {
                dateViewModel.selectedDate = dateObject.date
                dateViewModel.setDate()
                HapticManager.instance.impact(style: .soft)
            }
        } label: {
            VStack {
                if dateObject.day != -1 {
                    if logViewModel.listOfDates.contains(computedDate) {
                        VStack {
                            Text("\(dateObject.day)")
                                .font(.title3.bold())
                                .foregroundStyle(dateViewModel.isSameDay(dateOne: dateObject.date.timeIntervalSince1970, dateTwo: dateViewModel.selectedDate.timeIntervalSince1970) ? (theme.lightBaseColor == Colors.Primary.rawValue ? .reversePrimary : Color(.black)) : .primary)
                                .frame(maxWidth: .infinity)
                            Spacer()
                            Circle()
                                .fill(dateViewModel.isSameDay(dateOne: dateObject.date.timeIntervalSince1970, dateTwo: dateViewModel.selectedDate.timeIntervalSince1970) ? 
                                      (theme.lightBaseColor == Colors.Primary.rawValue ? .reversePrimary : .white) : Color(theme.lightBaseColor))
                                .frame(width: 8, height: 8)
                        }
                    } else {
                        VStack {
                            Text("\(dateObject.day)")
                                .font(.title3.bold())
                                .foregroundColor(dateViewModel.isSameDay(dateOne: dateObject.date.timeIntervalSince1970, dateTwo: dateViewModel.selectedDate.timeIntervalSince1970) ? (theme.lightBaseColor == Colors.Primary.rawValue ? .reversePrimary : Color(.black)) : .primary)
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
                .fill(theme.lightBaseColor == Colors.Primary.rawValue ?
                    .linearGradient(colors: [
                        .primary
                    ], startPoint: .top, endPoint: .bottom) :
                    .linearGradient(colors: [
                    Color(theme.lightBaseColor),
                    Color(theme.darkBaseColor)
                ], startPoint: .top, endPoint: .bottom))
                .padding(.horizontal, 8)
                .opacity(dateViewModel.isSameDay(dateOne: dateObject.date.timeIntervalSince1970, dateTwo: dateViewModel.selectedDate.timeIntervalSince1970) ? 1 : 0)
        )
    }
}
