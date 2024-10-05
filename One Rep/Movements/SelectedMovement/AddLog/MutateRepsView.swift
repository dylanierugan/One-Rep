//
//  MutateRepsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import Combine
import SwiftUI

struct MutateRepsView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var editLogViewModel: EditLogViewModel
    
    // MARK: - Public Properties
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Text(MutateStrings.Reps.rawValue)
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary).opacity(0.7)
            
            HStack(spacing: 0) {
                MutateRepsButton(isEditing: false, color: .primary, icon: Icons.Minus.rawValue, mutatingValue: -1)
                
                TextField("", text: $logViewModel.repsStr)
                    .onChange(of: logViewModel.repsStr) { newText, _ in
                        logViewModel.bindRepValues()
                    }
                    .accentColor(Color(theme.darkBaseColor))
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .padding(.vertical, 8)
                    .frame(width: 72, alignment: .center)
                    .cornerRadius(10)
                    .customFont(size: .title2, weight: .semibold, kerning: 0, design: .rounded)
                    .onReceive(Just(logViewModel.reps)) { _ in logViewModel.limitRepsText(3) }
                    .focused($isInputActive)
                    .onTapGesture {
                        logViewModel.repsStr = ""
                    }
                
                MutateRepsButton(isEditing: false, color: .primary, icon: Icons.Plus.rawValue, mutatingValue: 1)
            }
        }
    }    
}
