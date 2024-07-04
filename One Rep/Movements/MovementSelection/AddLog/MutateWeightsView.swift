//
//  MutateWeightsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import Combine
import SwiftUI

struct MutateWeightView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logController: LogController
    @EnvironmentObject var logViewModel: LogViewModel
    
    @State var mutatingValue: Double = 5
    @State var movement: Movement
    
    @FocusState var isInputActive: Bool
    
    let mutatingValues : [Double] = [2.5, 5, 10, 25]
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Menu {
                Picker("", selection: $mutatingValue) {
                    ForEach(mutatingValues, id: \.self) { value in
                        Text("± \(value.clean) \(logViewModel.unit.rawValue)")
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary).opacity(0.7)
                    }
                }
                .onChange(of: mutatingValue) {
                    
                }
            } label: {
                HStack {
                    Text("Weight (\(logViewModel.unit.rawValue))")
                        .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                        .foregroundColor(.secondary).opacity(0.7)
                    Image(systemName: Icons.ChevronCompactDown.rawValue)
                        .foregroundColor(.secondary).opacity(0.7)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 6)
            
            HStack(spacing: 0) {
                MutateWieghtButton(isEditing: false, color: .primary, icon: Icons.Minus.rawValue, mutatingValue: -mutatingValue)
                
                TextField("", value: $logController.weight, formatter: NumberFormatter.noDecimalUnlessNeeded)
                    .accentColor(Color(theme.darkBaseColor))
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                    .padding(.vertical, 8)
                    .frame(width: 72, alignment: .center)
                    .cornerRadius(10)
                    .customFont(size: .title2, weight: .semibold, kerning: 0, design: .rounded)
                    .focused($isInputActive)
                
                MutateWieghtButton(isEditing: false, color: .primary, icon: Icons.Plus.rawValue, mutatingValue: mutatingValue)
            }
        }
        .onAppear() {
            mutatingValue = movement.mutatingValue
        }
    }
}
