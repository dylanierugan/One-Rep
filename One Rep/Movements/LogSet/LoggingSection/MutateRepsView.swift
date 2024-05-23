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
    @EnvironmentObject var logDataViewModel: LogDataViewModel
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Text("Reps")
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary).opacity(0.7)
            
            HStack(spacing: 8) {
                MutateRepsButton(color: .primary, icon: Icons.Minus.description, mutatingValue: -1, mutateRep: mutateReps)
                
                TextField("", text: $logDataViewModel.repsStr)
                    .onChange(of: logDataViewModel.repsStr) { newText, _ in
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
                    .onReceive(Just(logDataViewModel.reps)) { _ in limitText(3) }
                    .focused($isInputActive)
                
                MutateRepsButton(color: .primary, icon: Icons.Plus.description, mutatingValue: 1, mutateRep: mutateReps)
            }
        }
    }
    
    // MARK: - Functions
    
    private func mutateReps(_ mutatingValue: Int) {
        if logDataViewModel.reps > 0 || logDataViewModel.reps < 999 {
            logDataViewModel.reps += mutatingValue
            logDataViewModel.repsStr = String(logDataViewModel.reps)
        }
    }
    
    private func bindValues() {
        if logDataViewModel.repsStr.isEmpty {
            logDataViewModel.reps = 0
        } else if let value = Int(logDataViewModel.repsStr) {
            logDataViewModel.reps = value
        } else {
            logDataViewModel.repsStr = String(logDataViewModel.reps)
        }
    }
    
    private func limitText(_ upper: Int) {
        if logDataViewModel.repsStr.count > upper {
            logDataViewModel.repsStr = String(logDataViewModel.repsStr.prefix(upper))
        }
    }
}
