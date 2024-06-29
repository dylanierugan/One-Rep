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
    
    var updateMovementInFirebase: () -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            withAnimation {
                updateMovementInFirebase()
            }
        } label: {
            HStack {
                Text("Update")
                    .foregroundStyle(.linearGradient(colors: [
                        Color(theme.lightBaseColor),
                        Color(theme.darkBaseColor)
                    ], startPoint: .top, endPoint: .bottom))
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
            }
        }
    }
}

