//
//  WeightHorizontalScroller.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/1/24.
//

import SwiftUI

import SwiftUI

struct WeightHorizontalScroller: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    
    @Binding var weightSelection: String
    
    @Binding var listOfWeights: [String]
    
    var filterWeightAndPopulateData:() -> Void
    
    var setMostRecentLog:() -> Void
    
    // MARK: - View
    
    var body: some View {
        /// Horizontal scrollview to allow for weight group selection
        if listOfWeights.count > 2  {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(listOfWeights, id: \.self) { weight in
                        Button {
                            weightSelection = weight
                            filterWeightAndPopulateData()
                            setMostRecentLog()
                            HapticManager.instance.impact(style: .soft)
                        } label: {
                            if weight == "All" {
                                Text(weight)
                                    .foregroundColor(weightSelection == weight ? .primary : .secondary.opacity(0.5))
                                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            } else {
                                Text("\(weight) lbs")
                                    .foregroundColor(weightSelection == weight ? .primary : .secondary.opacity(0.5))
                                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(weightSelection == weight ? Color(theme.backgroundElementColor) : Color(theme.backgroundElementColor).opacity(0.5))
                        .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 16)
                .onChange(of: weightSelection) { newValue, _ in
                    HapticManager.instance.impact(style: .soft)
                }
            }
        }
    }
    
    // MARK: - Function
    private func formatWeightString(_ weight: Double) -> String {
        if weight.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", weight)
        } else {
            return String(format: "%.1f", weight)
        }
    }
}
