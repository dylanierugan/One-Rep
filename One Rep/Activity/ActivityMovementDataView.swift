//
//  ActivityMovementDataView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/18/24.
//

import SwiftUI

struct ActivityMovementDataView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var dateViewModel: DateViewModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    
    // MARK: - View
    
    var body: some View {
        if let movementLogMap = logViewModel.dateMovementLogMap[logViewModel.formatDate(date: dateViewModel.selectedDate.timeIntervalSince1970)] {
            let sortedMovements = Array(movementLogMap.keys).sorted { $0.name < $1.name }
            VStack {
                ForEach(Array(sortedMovements), id: \.self) { movement in
                    NavigationLink {
                        LogView(movement: movement)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(movement.name)
                                .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                            if let logs = movementLogMap[movement] {
                                ForEach(Array(logs.enumerated()), id: \.element.id) { index, log in
                                    ActivityMovementCard(index: index, log: log)
                                }
                                .padding(.top, 4)
                            }
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(Color(theme.backgroundElementColor))
                    .cornerRadius(16)
                    .padding(.top, 16)
                }
            }
        } else {
            Text(InfoText.NoDataOnDay.rawValue)
                .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                .foregroundStyle(.secondary)
                .padding(.top, 72)
        }
    }
}

