//
//  EditMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct EditMovementButton: View {
    
    // MARK: - Public Properties
    
    @Binding var showEditMovementPopup: Bool
    @Binding var showDoneToolBar: Bool
    
    // MARK: - View
    
    var body: some View {
        Button {
            showEditMovementPopup.toggle()
            showDoneToolBar = false
        } label: {
            HStack {
                Image(systemName: Icons.RectangleAndPencilAndEllipsis.rawValue)
            }
            .customFont(size: .caption, weight: .bold, kerning: 0, design: .rounded)
            .foregroundColor(.primary)
        }
    }
}
