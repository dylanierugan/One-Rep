//
//  EditMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct EditMovementButton: View {
        
    @Binding var showEditMovementPopup: Bool
    @Binding var showDoneToolBar: Bool
    
    // MARK: - View
    
    var body: some View {
        Button {
            showEditMovementPopup.toggle()
            showDoneToolBar = false
        } label: {
            HStack {
                Image(systemName: Icons.RectangleAndPencilAndEllipsis.description)
            }
            .customFont(size: .caption, weight: .bold, kerning: 0, design: .rounded)
            .foregroundColor(.primary)
        }
    }
}
