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
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var logController: LogController
    
    @ObservedRealmObject var log: Log
    @ObservedRealmObject var movement: Movement
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 8) {
            MutateWieghtButton(color: .primary, icon: Icons.Minus.description, mutatingValue: -movement.mutatingValue)
            
            TextField("", value: $logController.weight,
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        logController.weight = log.weight
                    }
                }
            
            MutateWieghtButton(color: .primary, icon: Icons.Plus.description, mutatingValue: movement.mutatingValue)
        }
    }
}
