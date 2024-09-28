//
//  ActivityMovementCard.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/20/24.
//

import SwiftUI

struct ActivityMovementCard: View {
    
    
    // MARK: - Public Properties
    
    @ObservedObject var activityViewModel: ActivityViewModel
    
    var index: Int
    var log: Log
    
    // MARK: - View
    
    var body: some View {
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
            
            DataLabelWeight(log: log)
            Spacer()
            DataLabelReps(log: log)
        }
    }
}
