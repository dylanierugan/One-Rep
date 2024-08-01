//
//  SelectMovementsButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/23/24.
//

import SwiftUI

struct SelectMovementsButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    @Binding var routineName: String
    @Binding var selectedIcon: String
    @Binding var dismissBothViews: Bool
    var isFormValid: Bool
    
    // MARK: - View
    
    var body: some View {
        NavigationLink {
            SelectMovementsView(routineName: $routineName, selectedIcon: $selectedIcon, dismissBothViews: $dismissBothViews)
        } label: {
            HStack {
                Text(AddRoutineStrings.SelectMovements.rawValue)
                    .font(.body.weight(.regular))
                Image(systemName: Icons.ArrowshapeForwardFill.rawValue)
            }
            .foregroundColor(isFormValid ? Color(theme.lightBaseColor) : Color.secondary)
        }
        .disabled(!isFormValid)
    }
}

