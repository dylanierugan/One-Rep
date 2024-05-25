//
//  MoveWeekButtons.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/18/24.
//

import SwiftUI

struct MoveWeekButtons: View {
    
    @EnvironmentObject var dateViewModel: DateViewModel
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                dateViewModel.moveSelectedDate(forward: false)
                dateViewModel.setDate()
                HapticManager.instance.impact(style: .light)
            } label: {
                Image(systemName: Icons.ChevronLeft.description)
                    .font(.title2).bold()
                    .foregroundStyle(.primary)
            }
            Button {
                dateViewModel.moveSelectedDate(forward: true)
                dateViewModel.setDate()
                HapticManager.instance.impact(style: .light)
            } label: {
                Image(systemName: Icons.ChevronRight.description)
                    .font(.title2).bold()
                    .foregroundStyle(.primary)
            }
        }
    }
}
