//
//  UpdateMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/20/24.
//

import SwiftUI

struct UpdateMovementButton: View {
    
    // MARK: - Variables
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var theme: ThemeModel
    
    @State var updateMovementClicked = false
    
    var updateMovementInRealm: () -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            withAnimation {
                updateMovementClicked = true
                updateMovementInRealm()
                dismiss()
            }
        } label: {
            HStack {
                Text("Update")
                    .foregroundColor(Color(theme.darkBaseColor))
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                if updateMovementClicked {
                    ProgressView()
                        .padding(.leading, 4)
                } else {
                    Image(systemName: Icons.RectangleAndPencilAndEllipsis.description)
                        .foregroundColor(Color(theme.darkBaseColor))
                        .font(.body.weight(.semibold))
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(Color(theme.darkBaseColor).opacity(0.1))
            .cornerRadius(16)
        }
        .disabled(updateMovementClicked ? true : false)
    }
}

