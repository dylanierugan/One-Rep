//
//  AddMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import SwiftUI

struct AddMovementButton: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    @Environment(\.dismiss) private var dismiss
    
    @State var addMovementClicked = false
    
    var isFormValid: Bool
    
    var addMovementToRealm: () -> Void
    
    // MARK: - View
    
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
                    .foregroundColor(isFormValid ? Color(theme.darkBaseColor): Color.secondary)
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                if addMovementClicked {
                    ProgressView()
                        .padding(.leading, 4)
                } else {
                    Image(systemName: Icons.SquareAndPencil.description)
                        .foregroundColor(isFormValid ? Color(theme.darkBaseColor): Color.secondary)
                        .font(.body.weight(.regular))
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(isFormValid ? Color(theme.darkBaseColor).opacity(0.1) : .secondary.opacity(0.1))
            .cornerRadius(16)
        }
        .disabled(isFormValid ? false : true)
        .disabled(addMovementClicked ? true : false)
    }
}
