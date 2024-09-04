//
//  UpdateRoutineButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/7/24.
//

import SwiftUI

struct UpdateRoutineButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    var updateRoutineInFirebase: () -> Void
    
    // MARK: - Private Properties
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - View
    
    var body: some View {
        Button {
            withAnimation {
                updateRoutineInFirebase()
            }
        } label: {
            HStack {
                Text(EditRoutineStrings.Update.rawValue)
                    .foregroundStyle(.linearGradient(colors: [
                        Color(theme.lightBaseColor),
                        Color(theme.darkBaseColor)
                    ], startPoint: .top, endPoint: .bottom))
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
            }
        }
    }
}
