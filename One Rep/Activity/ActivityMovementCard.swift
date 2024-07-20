//
//  ActivityMovementCard.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/20/24.
//

import SwiftUI

struct ActivityMovementCard: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var logViewModel: LogViewModel
    
    // MARK: - Public Properties
    
    var index: Int
    var log: Log
    
    // MARK: - View
    
    var body: some View {
        let repStr = String(log.reps)
        HStack {
            HStack(alignment: .bottom) {
                Text(LogCardStrings.Set.rawValue)
                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                    .foregroundStyle(.secondary)
                Text(String(index + 1))
                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                    .foregroundStyle(.primary)
            }
            Spacer()
            DataLabel(data: logViewModel.convertWeightDoubleToString(log.weight + log.bodyweight), dataType: log.unit.rawValue)
            Spacer()
            DataLabel(data: repStr, dataType: LogCardStrings.Reps.rawValue)
        }
    }
}
