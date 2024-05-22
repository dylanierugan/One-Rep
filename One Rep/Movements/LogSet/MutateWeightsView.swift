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
    @EnvironmentObject var logDataViewModel: LogDataViewModel
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Text("Weight (lbs)")
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary).opacity(0.7)
            
            HStack(spacing: 8) {
                MutateWieghtButton(color: .primary, icon: Icons.Minus.description, mutatingValue: -2.5, mutateWeight: mutateWeight)
                
                TextField("", text: $logDataViewModel.weightStr)
                    .onChange(of: logDataViewModel.weightStr) { newText, _ in
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
                    .onReceive(Just(logDataViewModel.weight)) { _ in limitText(5) }
                    .focused($isInputActive)
                
                MutateWieghtButton(color: .primary, icon: Icons.Plus.description, mutatingValue: 2.5, mutateWeight: mutateWeight)
            }
        }
    }
    
    // MARK: - Functions
    
    private func mutateWeight(_ mutatingValue: Double) {
        if logDataViewModel.weight + mutatingValue >= 0 && logDataViewModel.weight + mutatingValue <= 999 {
            logDataViewModel.weight += mutatingValue
            updateWeightString()
        }
    }

    private func bindValues() {
        if logDataViewModel.weightStr.isEmpty {
            logDataViewModel.weight = 0.0
        } else if let value = Double(logDataViewModel.weightStr) {
            logDataViewModel.weight = value
            updateWeightString()
        } else {
            logDataViewModel.weightStr = formatWeightString(logDataViewModel.weight)
        }
    }

    private func updateWeightString() {
        logDataViewModel.weightStr = formatWeightString(logDataViewModel.weight)
    }

    private func formatWeightString(_ weight: Double) -> String {
        if weight.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", weight)
        } else {
            return String(format: "%.1f", weight)
        }
    }
    
    private func limitText(_ upper: Int) {
        if logDataViewModel.weightStr.count > upper {
            logDataViewModel.weightStr = String(logDataViewModel.weightStr.prefix(upper))
        }
    }
}
