//
//  EditWeightTextfield.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/22/24.
//

import SwiftUI
import RealmSwift
import Combine

struct EditWeightTextField: View {
    
    // MARK: - Variables
    
    @Environment(\.realm) var realm
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logDataViewModel: LogDataViewModel
    
    @ObservedRealmObject var log: Log
    @Binding var weight: Double
    @Binding var weightStr: String
    @Binding var mutatingValue: Double
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 8) {
            MutateWieghtButton(color: .primary, icon: Icons.Minus.description, mutatingValue: -mutatingValue, mutateWeight: mutateWeight)
            
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
                .frame(width: 84, alignment: .center)
                .cornerRadius(10)
                .customFont(size: .title3, weight: .semibold, kerning: 0, design: .rounded)
                .onReceive(Just(weight)) { _ in limitText(5) }
                .focused($isInputActive)
                .onAppear() {
                    weight = log.weight
                    weightStr = logDataViewModel.convertWeightDoubleToString(log.weight)
                }
            
            MutateWieghtButton(color: .primary, icon: Icons.Plus.description, mutatingValue: mutatingValue, mutateWeight: mutateWeight)
        }
    }
    
    // MARK: - Functions
    
    private func mutateWeight(_ mutatingValue: Double) {
        if weight + mutatingValue >= 0 && weight + mutatingValue <= 999 {
            weight += mutatingValue
            updateWeightString()
        }
    }
    
    private func formatWeightString(_ weight: Double) -> String {
        if weight.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", weight)
        } else {
            return String(format: "%.1f", weight)
        }
    }
    
    private func updateWeightString() {
        weightStr = formatWeightString(weight)
    }
    
    private func bindValues() {
        if weightStr.isEmpty {
            weight = 0.0
        } else if let value = Double(weightStr) {
            weight = value
            updateWeightString()
        } else {
            weightStr = formatWeightString(weight)
        }
    }
    
    private func limitText(_ upper: Int) {
        if weightStr.count > upper {
            weightStr = String(weightStr.prefix(upper))
        }
    }
}
