//
//  UpdateLogButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/23/24.
//

import SwiftUI

struct UpdateLogButton: View {
    
    // MARK: - Variables
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var theme: ThemeModel
    
    @State var updateLogClicked = false
    
    var updateLogInRealm: () -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            withAnimation {
                updateLogClicked = true
                updateLogInRealm()
                dismiss()
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
        .disabled(updateLogClicked ? true : false)
    }
}
