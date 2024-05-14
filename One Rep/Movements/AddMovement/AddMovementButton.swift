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
                Text("Add")
                    .foregroundStyle(isFormValid ?
                        .linearGradient(colors: [
                            Color(theme.lightBaseColor),
                            Color(theme.darkBaseColor)
                        ], startPoint: .top, endPoint: .bottom) :
                            .linearGradient(colors: [
                                .secondary
                            ], startPoint: .top, endPoint: .bottom))
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
            }
        }
        .disabled(isFormValid ? false : true)
        .disabled(addMovementClicked ? true : false)
    }
}
