//
//  MoveMonthButtons.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/18/24.
//

import SwiftUI

struct MoveMonthButtons: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var dateViewModel: DateViewModel
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                withAnimation {
                    dateViewModel.currentMonth -= 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        dateViewModel.setMonth()
                        dateViewModel.setYear()
                    }
                    HapticManager.instance.impact(style: .light)
                }
            } label: {
                Image(systemName: Icons.ChevronLeft.rawValue)
                    .font(.title2).bold()
                    .foregroundStyle(.primary)
            }
            Button {
                withAnimation {
                    dateViewModel.currentMonth += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        dateViewModel.setMonth()
                        dateViewModel.setYear()
                    }
                    HapticManager.instance.impact(style: .light)
                }
            } label: {
                Image(systemName: Icons.ChevronRight.rawValue)
                    .font(.title2).bold()
                    .foregroundStyle(.primary)
            }
        }
    }
}
