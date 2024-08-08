//
//  MovementTypePicker.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/3/24.
//

import SwiftUI

struct MovementTypePicker: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    @Binding var movementTypeSelection: MovementType
    var captionText: String
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(captionText)
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary)
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                    MovementTypePickerButton(movementTypeSelection: $movementTypeSelection, movementType: .Weight)
                    MovementTypePickerButton(movementTypeSelection: $movementTypeSelection, movementType: .Bodyweight)
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
            .frame(height: 48)
            .background(Color(theme.backgroundElementColor))
            .cornerRadius(16)
        }
    }
}

struct MovementTypePickerButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties

    @Binding var movementTypeSelection: MovementType
    var movementType: MovementType
    
    // MARK: - View
    
    var body: some View {
        Button(action: {
            withAnimation() {
                movementTypeSelection = movementType
                HapticManager.instance.impact(style: .soft)
            }
        }, label: {
            HStack {
                Text(movementType.rawValue)
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
            }
            .padding(.horizontal, 16)
            .frame(height: 28)
            .foregroundStyle(movementTypeSelection == movementType ? Color(.reversePrimary): .secondary)
            .background(movementTypeSelection == movementType ? Color(.customPrimary) : Color(.clear))
            .cornerRadius(8)
        })
    }
}
