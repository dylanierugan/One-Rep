//
//  AddMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import SwiftUI

struct SaveMovementButton: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var themeColor: ThemeColorModel
    
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
                    .foregroundColor(isFormValid ? Color(themeColor.Base): Color.secondary)
                    .customFont(size: .body, weight: .regular, kerning: 1, design: .rounded)
                if addMovementClicked {
                    ProgressView()
                        .padding(.leading, 4)
                } else {
                    Image(systemName: Icons.SquareAndPencil.description)
                        .foregroundColor(isFormValid ? Color(themeColor.Base): Color.secondary)
                        .font(.body.weight(.medium))
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(isFormValid ? .linearGradient(colors: [
                Color(themeColor.BaseLight).opacity(0.1),
                Color(themeColor.Base).opacity(0.1),
                Color(themeColor.BaseDark.description).opacity(0.1)
            ], startPoint: .topLeading, endPoint: .bottomTrailing) :
                    .linearGradient(colors: [
                        Color(themeColor.BackgroundElement)
                    ], startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(16)
        }
        .disabled(isFormValid ? false : true)
        .disabled(addMovementClicked ? true : false)
    }
}
