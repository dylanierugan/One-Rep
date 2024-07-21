//
//  EditRepsTextField.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/23/24.
//

import Combine
import SwiftUI

struct EditRepsTextField: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logController: LogController
    
    // MARK: - Public Properties
    
    @State var log: Log
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 8) {
            MutateRepsButton(isEditing: true, color: .primary, icon: Icons.Minus.rawValue, mutatingValue: -1)
            TextField("", text: $logController.editRepsStr)
                .onChange(of: logController.editRepsStr) { newText, _ in
                    logController.bindEditRepValues()
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
                .onReceive(Just(logController.editReps)) { _ in logController.limitEditRepsText(3) }
                .focused($isInputActive)
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        logController.editReps = log.reps
                        logController.editRepsStr = String(log.reps)
                    }
                }
            MutateRepsButton(isEditing: true, color: .primary, icon: Icons.Plus.rawValue, mutatingValue: 1)
        }
    }
}
