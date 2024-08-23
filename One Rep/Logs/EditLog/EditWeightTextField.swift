//
//  EditWeightTextfield.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/22/24.
//

import SwiftUI
import Combine

struct EditWeightTextField: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var editLogViewModel: EditLogViewModel
    
    // MARK: - Public Properties
    
    @State var log: Log
    @State var movement: Movement
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 8) {
            MutateWieghtButton(isEditing: true, color: .primary, icon: Icons.Minus.rawValue, mutatingValue: -movement.mutatingValue)
            TextField("", value: $editLogViewModel.editWeight,
                      formatter: NumberFormatter.noDecimalUnlessNeeded)
                .accentColor(Color(theme.darkBaseColor))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(.secondary.opacity(0.05))
                .frame(width: 84, alignment: .center)
                .cornerRadius(10)
                .customFont(size: .title3, weight: .semibold, kerning: 0, design: .rounded)
                .focused($isInputActive)
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        logViewModel.weight = log.weight
                    }
                }
            MutateWieghtButton(isEditing: true, color: .primary, icon: Icons.Plus.rawValue, mutatingValue: movement.mutatingValue)
        }
    }
}
