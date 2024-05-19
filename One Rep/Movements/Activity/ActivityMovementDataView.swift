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
    @EnvironmentObject var logDataController: LogDataController
    @EnvironmentObject var dateViewModel: DateViewModel
    
    // MARK: - View
    
    var body: some View {
        if let movementLogMap = logDataController.dateMovementLogMap[logDataController.formatDate(date: dateViewModel.selectedDate.timeIntervalSince1970)] {
            let sortedMovements = Array(movementLogMap.keys).sorted { $0.name < $1.name }
            VStack {
                ForEach(Array(sortedMovements), id: \.self) { movement in
                    VStack(alignment: .leading) {
                        Text(movement.name)
                            .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                        if let logs = movementLogMap[movement]{
                            ForEach(logs.reversed() , id: \.id) { log in
                                let weightStr = logDataController.convertWeightDoubleToString(log.weight)
                                let repStr = String(log.reps)
                                HStack {
                                    TimeLabel(date: log.date)
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
