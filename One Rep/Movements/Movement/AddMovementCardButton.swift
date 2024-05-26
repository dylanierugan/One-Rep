//
//  AddMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import SwiftUI

struct AddMovementCardButton: View {
    
    @EnvironmentObject var theme: ThemeModel
    
    @Binding var showAddMovementPopup: Bool
    
    // MARK: - View
    
    var body: some View {
        Button {
            showAddMovementPopup = true
        } label: {
            HStack {
                Image(systemName: Icons.Plus.description)
                    .font(.body.bold())
                    .foregroundStyle(.primary)
            }
        }
    }
}
