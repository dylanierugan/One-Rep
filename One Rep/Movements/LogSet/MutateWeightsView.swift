//
//  MutateWeightsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import Combine
import SwiftUI

struct MutateWeightView: View {
    
    // MARK: - Variables
    @EnvironmentObject var theme: ThemeModel
    
    @Binding var weight: Double
    @Binding var weightStr: String
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Text("Weight (lbs)")
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary).opacity(0.7)
            
            HStack(spacing: 8) {
                MutateWieghtButton(color: .primary, icon: Icons.Minus.description, mutatingValue: -2.5, mutateWeight: mutateWeight)
                
                TextField("", text: $weightStr)
                    .onChange(of: weightStr) { newText, _ in
                        bindValues()
                    }
                    .accentColor(Color(theme.darkBaseColor))
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(.secondary.opacity(0.05))
                    .frame(width: 80, alignment: .center)
                    .cornerRadius(10)
                    .customFont(size: .title3, weight: .semibold, kerning: 0, design: .rounded)
                    .onReceive(Just(weight)) { _ in limitText(5) }
                    .focused($isInputActive)
                
                MutateWieghtButton(color: .primary, icon: Icons.Plus.description, mutatingValue: 2.5, mutateWeight: mutateWeight)
            }
        }
    }
    
    // MARK: - Functions
    
    private func mutateWeight(_ mutatingValue: Double) {
        if weight + mutatingValue >= 0 && weight + mutatingValue <= 999 {
            weight += mutatingValue
            updateWeightString()
        }
    }

    private func bindValues() {
        if let value = Double(weightStr) {
            weight = value
            updateWeightString()
        } else {
            weightStr = formatWeightString(weight)
        }
    }

    private func updateWeightString() {
        weightStr = formatWeightString(weight)
    }

    private func formatWeightString(_ weight: Double) -> String {
        if weight.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", weight)
        } else {
            return String(format: "%.1f", weight)
        }
    }
    
    private func limitText(_ upper: Int) {
        if weightStr.count > upper {
            weightStr = String(weightStr.prefix(upper))
        }
    }
}
