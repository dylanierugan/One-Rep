//
//  EditRepsTextField.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/23/24.
//

import Combine
import SwiftUI
import RealmSwift

struct EditRepsTextField: View {
    
    // MARK: - Variables
    
    @Environment(\.realm) var realm
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logController: LogController
    
    @ObservedRealmObject var log: Log
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 8) {
            MutateRepsButton(color: .primary, icon: Icons.Minus.description, mutatingValue: -1)
            
            TextField("", text: $logController.repsStr)
                .onChange(of: logController.repsStr) { newText, _ in
                    logController.bindRepValues()
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
                .onReceive(Just(logController.reps)) { _ in logController.limitRepsText(3) }
                .focused($isInputActive)
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        logController.reps = log.reps
                        logController.repsStr = String(log.reps)
                    }
                }
            
            MutateRepsButton(color: .primary, icon: Icons.Plus.description, mutatingValue: 1)
        }
    }
}
