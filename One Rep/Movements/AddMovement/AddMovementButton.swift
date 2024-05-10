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
                    .foregroundColor(isFormValid ? .black : Color.secondary)
                    .customFont(size: .caption, weight: .semibold, kerning: 0, design: .rounded)
                if addMovementClicked {
                    ProgressView()
                        .padding(.leading, 4)
                } else {
                    Image(systemName: Icons.SquareAndPencil.description)
                        .foregroundColor(isFormValid ? .black : Color.secondary)
                        .font(.caption.weight(.semibold))
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                isFormValid ?
                    .linearGradient(colors: [
                        Color(theme.lightBaseColor),
                        Color(theme.darkBaseColor)
                    ], startPoint: .top, endPoint: .bottom) :
                        .linearGradient(colors: [
                            .clear
                        ], startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(16)
        }
        .disabled(isFormValid ? false : true)
        .disabled(addMovementClicked ? true : false)
    }
}
