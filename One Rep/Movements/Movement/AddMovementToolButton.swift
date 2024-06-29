//
//  AddMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import SwiftUI

struct AddMovementToolButton: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    
    @Binding var showAddMovementPopup: Bool
    
    // MARK: - View
    
    var body: some View {
        Button {
            showAddMovementPopup = true
        } label: {
            HStack {
                Image(systemName: Icons.Plus.rawValue)
                    .font(.body.bold())
                    .foregroundStyle(.primary)
            }
        }
    }
}
