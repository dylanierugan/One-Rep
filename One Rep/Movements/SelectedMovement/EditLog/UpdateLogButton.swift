//
//  UpdateLogButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/23/24.
//

import SwiftUI

struct UpdateLogButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    var updateLogInFirebase: () -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            withAnimation {
                updateLogInFirebase()
            }
        } label: {
            HStack {
                Text(EditLogStrings.Update.rawValue)
                    .foregroundStyle(.linearGradient(colors: [
                        Color(theme.lightBaseColor),
                        Color(theme.darkBaseColor)
                    ], startPoint: .top, endPoint: .bottom))
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
            }
        }
    }
}
