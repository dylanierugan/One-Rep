//
//  AddMovementsToolButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/5/24.
//

import SwiftUI

struct AddMovementsToolButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Public Properties
    
    @Binding var showAddMovmenetsSheet: Bool
    
    // MARK: - View
    
    var body: some View {
        Button {
            showAddMovmenetsSheet.toggle()
        } label: {
            Image(systemName: Icons.TextBadgePlus.rawValue)
                .customFont(size: .caption, weight: .semibold)
        }
    }
}
