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
                    .foregroundColor(.black)
                    .customFont(size: .caption, weight: .semibold, kerning: 0, design: .rounded)
                if updateMovementClicked {
                    ProgressView()
                        .padding(.leading, 4)
                } else {
                    Image(systemName: Icons.RectangleAndPencilAndEllipsis.description)
                        .foregroundColor(.black)
                        .font(.caption.weight(.semibold))
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(
                .linearGradient(colors: [
                    Color(theme.lightBaseColor),
                    Color(theme.darkBaseColor)
                ], startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(16)
        }
        .disabled(updateMovementClicked ? true : false)
    }
}

