//
//  AddMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import SwiftUI

struct AddMovementButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Public Properties
    
    var isFormValid: Bool
    var addMovementToFirebase:() -> Void
    
    // MARK: - Private Properties
    
    @State private var addMovementClicked = false
    
    // MARK: - View
    
    var body: some View {
        Button {
            addMovementToFirebase()
        } label: {
            HStack {
                Text(AddMovementStrings.Add.rawValue)
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
