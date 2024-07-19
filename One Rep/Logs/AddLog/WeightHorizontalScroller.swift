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
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var logController: LogController
    
    // MARK: - Public Properties
    
    @State var movement: Movement
    
    // MARK: - View
    
    var body: some View {
        if logViewModel.listOfWeights.count > 2  {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(logViewModel.listOfWeights, id: \.self) { weight in
                        Button {
                            logViewModel.repopulateViewModel(weightSelection: weight, movement: movement)
                            logController.setMostRecentLog(logViewModel.filteredLogs, weightSelection: logViewModel.weightSelection, isBodyweight: movement.movementType == .Bodyweight ? true : false)
                            HapticManager.instance.impact(style: .soft)
                        } label: {
                            if weight == WeightSelection.All.rawValue  {
                                Text(weight)
                                    .foregroundColor(logViewModel.weightSelection == weight ? .primary : .secondary.opacity(0.8))
                                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            } else {
                                Text("\(weight) \(logViewModel.unit.rawValue)")
                                    .foregroundColor(logViewModel.weightSelection == weight ? .primary : .secondary.opacity(0.8))
                                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(logViewModel.weightSelection == weight ? Color(theme.backgroundElementColor) : Color(theme.backgroundElementColor).opacity(0.8))
                        .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 16)
                .onChange(of: logViewModel.weightSelection) { newValue, _ in
                    HapticManager.instance.impact(style: .soft)
                }
            }
        }
    }
}
