//
//  UpdateMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/20/24.
//

import SwiftUI

struct UpdateMovementButton: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var theme: ThemeModel
    
    @State var updateMovementClicked = false
    var isFormValid: Bool
    
    var updateMovementInRealm: () -> Void
    
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
                    .foregroundColor(isFormValid ? Color(theme.BaseColor): Color.secondary)
                    .customFont(size: .body, weight: .regular, kerning: 0, design: .rounded)
                if updateMovementClicked {
                    ProgressView()
                        .padding(.leading, 4)
                } else {
                    Image(systemName: Icons.RectangleAndPencilAndEllipsis.description)
                        .foregroundColor(isFormValid ? Color(theme.BaseColor): Color.secondary)
                        .font(.body.weight(.regular))
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(isFormValid ? .linearGradient(colors: [
                Color(theme.BaseLightColor).opacity(0.1),
                Color(theme.BaseColor).opacity(0.1),
            ], startPoint: .top, endPoint: .bottom) :
                    .linearGradient(colors: [
                        Color.secondary.opacity(0.1)
                    ], startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(16)
        }
        .disabled(isFormValid ? false : true)
        .disabled(updateMovementClicked ? true : false)
    }
}

