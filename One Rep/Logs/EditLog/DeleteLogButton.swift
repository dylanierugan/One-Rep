//
//  DeleteLogButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/23/24.
//

import SwiftUI

struct DeleteLogButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Public Properties
    
    var deleteMovementInFirebase: () -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            deleteMovementInFirebase()
        } label: {
            Text(EditLogStrings.Delete.rawValue)
                .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                .foregroundStyle(.linearGradient(colors: [
                    Color(theme.lightRed),
                    Color(theme.darkRed)
                ], startPoint: .top, endPoint: .bottom))
        }
    }
}
