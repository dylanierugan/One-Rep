//
//  MutateRepsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import Combine
import SwiftUI

struct MutateRepsView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logController: LogController
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Text("Reps")
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary).opacity(0.7)
            
            HStack(spacing: 0) {
                MutateRepsButton(color: .primary, icon: Icons.Minus.rawValue, mutatingValue: -1)
                
                TextField("", text: $logController.repsStr)
                    .onChange(of: logController.repsStr) { newText, _ in
                        logController.bindRepValues()
                    }
                    .accentColor(Color(theme.darkBaseColor))
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .padding(.vertical, 8)
                    .frame(width: 72, alignment: .center)
                    .cornerRadius(10)
                    .customFont(size: .title2, weight: .semibold, kerning: 0, design: .rounded)
                    .onReceive(Just(logController.reps)) { _ in logController.limitRepsText(3) }
                    .focused($isInputActive)
                
                MutateRepsButton(color: .primary, icon: Icons.Plus.rawValue, mutatingValue: 1)
            }
        }
    }    
}
