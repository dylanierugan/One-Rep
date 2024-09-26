//
//  EditMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct EditMovementButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    var movement: Movement
    @Binding var showEditMovementPopup: Bool
    @Binding var showDoneToolBar: Bool
    
    // MARK: - View
    
    var body: some View {
        Button {
            showEditMovementPopup.toggle()
            showDoneToolBar = false
        } label: {
            HStack(spacing: 12) {
                Image(movement.muscleGroup.rawValue.lowercased())
                    .font(.caption2)
                    .foregroundStyle(.linearGradient(colors: [
                        Color(theme.lightBaseColor),
                        Color(theme.darkBaseColor)
                    ], startPoint: .top, endPoint: .bottom))
                Text(movement.name)
                    .customFont(size: .body, weight: .bold, design: .rounded)
                Image(systemName: Icons.ChevronRight.rawValue)
                    .customFont(size: .caption2, weight: .bold)
                    .foregroundStyle(.secondary)
                    .padding(.leading, -4)
            }
        }
    }
}
