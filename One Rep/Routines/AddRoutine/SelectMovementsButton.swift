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
    
    @ObservedObject var addRoutineViewModel: AddRoutineViewModel
    
    // MARK: - Private Properties
    
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - View
    
    var body: some View {
        NavigationLink {
            SelectMovementsView(addRoutineViewModel: addRoutineViewModel)
        } label: {
            HStack {
                Text(AddRoutineStrings.SelectMovements.rawValue)
                    .font(.body.weight(.regular))
                Image(systemName: Icons.ArrowshapeForwardFill.rawValue)
            }
            .foregroundColor(addRoutineViewModel.isFormNameValid ? (colorScheme == .dark ? Color(theme.lightBaseColor) : Color(theme.darkBaseColor)) : Color.secondary)
        }
        .disabled(addRoutineViewModel.isFormNameValid == false)
    }
}

