//
//  DateView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/18/24.
//

import SwiftUI

struct DateView: View {
    
    // MARK: - Public Properties
    
    @ObservedObject var dateViewModel: DateViewModel
    
    // MARK: - View
    
    var body: some View {
        HStack(alignment: .center) {
            Text("\(dateViewModel.formattedSelectedDate())")
                .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                .foregroundStyle(.primary)
            Spacer()
            if !dateViewModel.isSameDay(dateOne: dateViewModel.selectedDate.timeIntervalSince1970, dateTwo: Date().timeIntervalSince1970) {
                Button {
                    withAnimation {
                        dateViewModel.selectedDate = Date()
                        dateViewModel.setDate()
                    }
                    HapticManager().impact(style: .soft)
                } label: {
                    HStack {
                        Text(DateStrings.GoToToday.rawValue)
                            .foregroundStyle(.primary)
                            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                    }
                }
            }
        }

    }
}
