//
//  EditMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct EditMovementButton: View {
    var body: some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: Icons.RectangleAndPencilAndEllipsis.description)
            }
            .customFont(size: .caption, weight: .bold, kerning: 0, design: .rounded)
            .foregroundColor(.primary)
        }
    }
}
