//
//  ShowCalendarButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/18/24.
//

import SwiftUI

struct ShowCalendarButton: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    
    @Binding var showCalendar: Bool
    
    // MARK: - View
    
    var body: some View {
        Button {
            withAnimation {
                showCalendar.toggle()
            }
        } label: {
            Image(systemName: Icons.Calendar.description)
                .font(.body)
                .foregroundStyle(showCalendar ? 
                    .linearGradient(colors: [
                        Color(theme.lightBaseColor),
                        Color(theme.darkBaseColor)
                    ], startPoint: .top, endPoint: .bottom) :
                        .linearGradient(colors: [
                            .primary
                        ], startPoint: .top, endPoint: .bottom))
        }
    }
}
