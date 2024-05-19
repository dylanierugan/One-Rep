//
//  ActivityMovementDataView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/18/24.
//

import SwiftUI

struct ActivityMovementDataView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logDataViewModel: LogDataViewModel
    @EnvironmentObject var dateViewModel: DateViewModel
    
    // MARK: - View
    
    var body: some View {
        if let movementLogMap = logDataViewModel.dateMovementLogMap[logDataViewModel.formatDate(date: dateViewModel.selectedDate.timeIntervalSince1970)] {
            let sortedMovements = Array(movementLogMap.keys).sorted { $0.name < $1.name }
            VStack {
                ForEach(Array(sortedMovements), id: \.self) { movement in
                    VStack(alignment: .leading) {
                        Text(movement.name)
                            .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                        if let logs = movementLogMap[movement]{
                            ForEach(Array(logs.enumerated()), id: \.element.id) { index, log in
                                let weightStr = logDataViewModel.convertWeightDoubleToString(log.weight)
                                let repStr = String(log.reps)
                                HStack {
                                    HStack(spacing: 12) {
                                        LogIndexLabel(index: index + 1)
                                        TimeLabel(date: log.date)
                                    }
                                    Spacer()
                                    DataLabel(data: weightStr, dataType: "lbs")
                                    Spacer()
                                    DataLabel(data: repStr, dataType: "reps")
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
            Text(InfoText.NoDataOnDay.description)
                .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                .foregroundStyle(.secondary)
                .padding(.top, 72)
        }
    }
}
