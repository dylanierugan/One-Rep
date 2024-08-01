//
//  UpdateMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/20/24.
//

import SwiftUI

struct UpdateMovementButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Public Properties
    
    var updateMovementInFirebase: () -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            withAnimation {
                updateMovementInFirebase()
            }
        } label: {
            HStack {
                Text(EditMovementStrings.Update.rawValue)
                    .foregroundStyle(.linearGradient(colors: [
                        Color(theme.lightBaseColor),
                        Color(theme.darkBaseColor)
                    ], startPoint: .top, endPoint: .bottom))
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
            }
        }
    }
}

