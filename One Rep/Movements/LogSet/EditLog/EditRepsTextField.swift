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
    @EnvironmentObject var logDataViewModel: LogDataViewModel
    
    @ObservedRealmObject var log: Log
    @Binding var reps: Int
    @Binding var repsStr: String
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 8) {
            MutateRepsButton(color: .primary, icon: Icons.Minus.description, mutatingValue: -1, mutateRep: mutateReps)
            
            TextField("", text: $repsStr)
                .onChange(of: repsStr) { newText, _ in
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
                .onReceive(Just(reps)) { _ in limitText(3) }
                .focused($isInputActive)
                .onAppear() {
                    reps = log.reps
                    repsStr = String(log.reps)
                }
            
            MutateRepsButton(color: .primary, icon: Icons.Plus.description, mutatingValue: 1, mutateRep: mutateReps)
        }
    }
    
    // MARK: - Functions
    
    private func mutateReps(_ mutatingValue: Int) {
        if reps > 0 || reps < 999 {
            reps += mutatingValue
            repsStr = String(reps)
        }
    }
    
    private func bindValues() {
        if repsStr.isEmpty {
            reps = 0
        } else if let value = Int(repsStr) {
            reps = value
        } else {
            repsStr = String(reps)
        }
    }
    
    private func limitText(_ upper: Int) {
        if repsStr.count > upper {
            repsStr = String(repsStr.prefix(upper))
        }
    }
}
