//
//  MutateRepsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import Combine
import SwiftUI

struct MutateRepsView: View {
    
    @EnvironmentObject var theme: ThemeModel
    
    var color: Color
    @Binding var reps: Int
    @Binding var repsStr: String
    @FocusState var isInputActive: Bool
    
    var body: some View {
        VStack {
            Text("Reps")
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary).opacity(0.7)
            
            HStack(spacing: 8)  {
                MutateRepsButton(color: .primary, icon: Icons.Minus.description, mutatingValue: -1, mutateRep: mutateReps)
                
                TextField("", text: $repsStr)
                    .onChange(of: repsStr) { newText, _ in
                        bindValues()
                    }
                    .accentColor(color)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(.secondary.opacity(0.05))
                    .frame(width: 80, alignment: .center)
                    .cornerRadius(10)
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                    .onReceive(Just(reps)) { _ in limitText(3) }
                    .focused($isInputActive)
                
                MutateRepsButton(color: .primary, icon: Icons.Plus.description, mutatingValue: 1, mutateRep: mutateReps)
            }
        }
    }
    
    func mutateReps(_ mutatingValue: Int) {
        if reps > 0 || reps < 999 {
            reps += mutatingValue
            repsStr = String(reps)
        }
    }
    
    func bindValues() {
        if let value = Int(repsStr) {
            reps = value
        } else {
            repsStr = String(reps)
        }
    }
    
    func limitText(_ upper: Int) {
        if repsStr.count > upper {
            repsStr = String(repsStr.prefix(upper))
        }
    }
}
