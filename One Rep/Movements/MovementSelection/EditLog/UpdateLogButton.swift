//
//  UpdateLogButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/23/24.
//

import SwiftUI

struct UpdateLogButton: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    var updateLogInFirebase: () -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            withAnimation {
                updateLogInFirebase()
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
