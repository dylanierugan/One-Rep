//
//  AddRoutineButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/27/24.
//

import SwiftUI

struct AddRoutineButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    var isFormValid: Bool
    var addRoutineToFirebase:() -> Void
    
    // MARK: - Private Properties
    
    @State private var addRoutineClicked = false
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - View
    
    var body: some View {
        Button {
            addRoutineToFirebase()
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
        .disabled(!isFormValid)
        .disabled(addRoutineClicked ? true : false)
    }
}
