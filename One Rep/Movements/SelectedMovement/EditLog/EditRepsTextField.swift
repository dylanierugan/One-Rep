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
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var editLogViewModel: EditLogViewModel
    
    // MARK: - Public Properties
    
    @State var log: Log
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 8) {
            MutateRepsButton(isEditing: true, color: .primary, icon: Icons.Minus.rawValue, mutatingValue: -1)
            TextField("", text: $editLogViewModel.repsStr)
                .onChange(of: editLogViewModel.repsStr) { newText, _ in
                    editLogViewModel.bindEditRepValues()
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
                .onReceive(Just(editLogViewModel.reps)) { _ in editLogViewModel.limitEditRepsText(3) }
                .focused($isInputActive)
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        editLogViewModel.reps = log.reps
                        editLogViewModel.repsStr = String(log.reps)
                    }
                }
                .onTapGesture {
                    editLogViewModel.repsStr = ""
                }
            MutateRepsButton(isEditing: true, color: .primary, icon: Icons.Plus.rawValue, mutatingValue: 1)
        }
    }
}
