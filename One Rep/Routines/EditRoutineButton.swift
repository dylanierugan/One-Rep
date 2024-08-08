//
//  EditRoutineButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/7/24.
//

import SwiftUI

struct EditRoutineButton: View {
    
    // MARK: - Public Properties
    
    @Binding var showEditRoutinePopup: Bool

    // MARK: - View
    
    var body: some View {
        Button {
            showEditRoutinePopup.toggle()
        } label: {
            HStack {
                Image(systemName: Icons.RectangleAndPencilAndEllipsis.rawValue)
            }
            .customFont(size: .caption, weight: .bold, kerning: 0, design: .rounded)
            .foregroundColor(.primary)
        }
    }
}
