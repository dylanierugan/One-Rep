//
//  WeightHorizontalScroller.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/1/24.
//

import SwiftUI

struct WeightHorizontalScroller: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var logController: LogController
    
    // MARK: - Public Properties
    
    @State var movement: Movement
    
    // MARK: - View
    
    var body: some View {
        if logsViewModel.listOfWeights.count > 2  {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(logsViewModel.listOfWeights, id: \.self) { weight in
                        Button {
                            logsViewModel.repopulateViewModel(weightSelection: weight, movement: movement)
                            logController.setMostRecentLog(logsViewModel.filteredLogs, weightSelection: logsViewModel.weightSelection, isBodyweight: movement.movementType == .Bodyweight ? true : false)
                            HapticManager.instance.impact(style: .soft)
                        } label: {
                            if weight == WeightSelection.All.rawValue  {
                                Text(weight)
                                    .foregroundColor(logsViewModel.weightSelection == weight ? .primary : .secondary.opacity(0.8))
                                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            } else {
                                Text("\(weight) \(logsViewModel.unit.rawValue)")
                                    .foregroundColor(logsViewModel.weightSelection == weight ? .primary : .secondary.opacity(0.8))
                                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(logsViewModel.weightSelection == weight ? Color(theme.backgroundElementColor) : Color(theme.backgroundElementColor).opacity(0.8))
                        .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 16)
                .onChange(of: logsViewModel.weightSelection) { newValue, _ in
                    HapticManager.instance.impact(style: .soft)
                }
            }
        }
    }
}
