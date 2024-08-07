//
//  MovementPicker.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/12/24.
//

import SwiftUI

struct MovementSelectionPicker: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    
    // MARK: - Public Properties
    
    @Binding var movementSelection: MovementSelection
    
    // MARK: - View
    
    var body: some View {
        HStack {
            MovementPickerButton(selection: .Library, movementSelection: $movementSelection)
            if movementsViewModel.movements.count != 0 {
                MovementPickerButton(selection: .Routines, movementSelection: $movementSelection)
            }
            MovementPickerButton(selection: .Activity, movementSelection: $movementSelection)
        }
        .background(Color(theme.backgroundElementColor))
        .cornerRadius(16)
    }
}

struct MovementPickerButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    var selection: MovementSelection
    @Binding var movementSelection: MovementSelection
    
    // MARK: - View
    
    var body: some View {
        Button(action: {
            withAnimation() {
                movementSelection = selection
                HapticManager.instance.impact(style: .soft)
            }
        }, label: {
            HStack {
                Spacer()
                Text(selection.rawValue)
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                Spacer()
            }
            .padding(.vertical, 6)
            .foregroundStyle(movementSelection == selection  ? Color(.reversePrimary): .primary)
            .background(movementSelection == selection ? Color(.customPrimary).opacity(0.9) : .clear)
            .cornerRadius(16)
            .padding(4)
        })
    }
}
