//
//  AddMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import SwiftUI

struct SaveMovementButton: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var theme: ThemeModel
    
    @State var addMovementClicked = false
    var isFormValid: Bool
    
    var addMovementToRealm: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                addMovementClicked = true
                addMovementToRealm()
                dismiss()
            }
        } label: {
            HStack {
                Text("Add Movement")
                    .foregroundColor(isFormValid ? Color(theme.BaseColor): Color.secondary)
                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                if addMovementClicked {
                    ProgressView()
                        .padding(.leading, 4)
                } else {
                    Image(systemName: Icons.SquareAndPencil.description)
                        .foregroundColor(isFormValid ? Color(theme.BaseColor): Color.secondary)
                        .font(.body.weight(.regular))
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(isFormValid ? .linearGradient(colors: [
                Color(theme.BaseLightColor).opacity(0.1),
                Color(theme.BaseColor).opacity(0.1),
            ], startPoint: .top, endPoint: .bottom) :
                    .linearGradient(colors: [
                        .clear
                    ], startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(16)
        }
        .disabled(isFormValid ? false : true)
        .disabled(addMovementClicked ? true : false)
    }
}
