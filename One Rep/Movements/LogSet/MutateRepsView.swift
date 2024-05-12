//
//  MutateRepsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import Combine
import SwiftUI

struct MutateRepsView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logDataController: LogDataController
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Text("Reps")
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary).opacity(0.7)
            
            HStack(spacing: 8)  {
                MutateRepsButton(color: .primary, icon: Icons.Minus.description, mutatingValue: -1, mutateRep: mutateReps)
                
                TextField("", text: $logDataController.repsStr)
                    .onChange(of: logDataController.repsStr) { newText, _ in
                        bindValues()
                    }
                    .accentColor(Color(theme.darkBaseColor))
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(.secondary.opacity(0.05))
                    .frame(width: 80, alignment: .center)
                    .cornerRadius(10)
                    .customFont(size: .title3, weight: .semibold, kerning: 0, design: .rounded)
                    .onReceive(Just(logDataController.reps)) { _ in limitText(3) }
                    .focused($isInputActive)
                
                MutateRepsButton(color: .primary, icon: Icons.Plus.description, mutatingValue: 1, mutateRep: mutateReps)
            }
        }
    }
    
    // MARK: - Functions
    
    private func mutateReps(_ mutatingValue: Int) {
        if logDataController.reps > 0 || logDataController.reps < 999 {
            logDataController.reps += mutatingValue
            logDataController.repsStr = String(logDataController.reps)
        }
    }
    
    private func bindValues() {
        if let value = Int(logDataController.repsStr) {
            logDataController.reps = value
        } else {
            logDataController.repsStr = String(logDataController.reps)
        }
    }
    
    private func limitText(_ upper: Int) {
        if logDataController.repsStr.count > upper {
            logDataController.repsStr = String(logDataController.repsStr.prefix(upper))
        }
    }
}
