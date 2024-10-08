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
    @EnvironmentObject var logViewModel: LogViewModel
    
    // MARK: - Public Properties
    
    @State var movement: Movement
    
    // MARK: - View
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(logsViewModel.listOfWeights, id: \.self) { weight in
                    Button {
                        weightButtonTapped(weight: weight)
                    } label: {
                        if weight == WeightSelection.All.rawValue {
                            Text(weight)
                                .foregroundColor(logsViewModel.weightSelection == weight ? .primary : .secondary.opacity(0.8))
                                .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                        } else if weight == WeightSelection.Zero.rawValue {
                            Text(WeightSelection.NoWeight.rawValue)
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
    
    // MARK: - Functions
    
    private func weightButtonTapped(weight: String) {
        logsViewModel.weightSelection = weight
        logsViewModel.filterLogsByWeightSelection(weightSelection: logsViewModel.weightSelection, movementId: movement.id)
        logViewModel.setLastLog(logsViewModel.filteredLogs, isBodyweight: movement.movementType == .Bodyweight ? true : false)
        HapticManager.instance.impact(style: .soft)
    }
}
