//
//  MutateWeightsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import Combine
import SwiftUI

struct MutateWeightView: View {
    
    var color: Color
    @Binding var weight: Double
    @Binding var weightStr: String
    
    var body: some View {
        VStack {
            Text("Weight (lbs)")
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary).opacity(0.7)
            
            HStack(spacing: 16) {
                MutateWieghtButton(color: .primary, icon: Icons.MinusCircleFill.description, mutatingValue: -2.5, mutateWeight: mutateWeight)
                
                TextField("", text: $weightStr)
                    .onChange(of: weightStr) { newText, _ in
                        bindValues()
                    }
                    .accentColor(color)
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(.secondary.opacity(0.05))
                    .frame(width: 80, alignment: .center)
                    .cornerRadius(10)
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                    .onReceive(Just(weight)) { _ in limitText(5) }
                
                MutateWieghtButton(color: .primary, icon: Icons.PlusCircleFill.description, mutatingValue: 2.5, mutateWeight: mutateWeight)
                
            }
        }
    }
    
    
    func mutateWeight(_ mutatingValue: Double) {
        if weight > 0 || weight < 999 {
            weight += mutatingValue
            weightStr = String(format: "%.1f", weight)
        }
    }
    
    func bindValues() {
        if let value = Double(weightStr) {
            weight = value
        } else {
            weightStr = String(format: "%.00f", weight)
        }
    }
    
    func limitText(_ upper: Int) {
        if weightStr.count > upper {
            weightStr = String(weightStr.prefix(upper))
        }
    }
}
