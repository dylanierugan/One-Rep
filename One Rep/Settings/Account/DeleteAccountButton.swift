//
//  DeleteAccountButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/24/24.
//

import SwiftUI
import RealmSwift

struct DeleteAccountButton: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var app: RealmSwift.App
    @EnvironmentObject var theme: ThemeModel
    
    
    // MARK: - View
    var body: some View {
        Button {
            /// Delete User
        } label: {
            HStack(spacing: 16) {
                Image(systemName: Icons.Trash.description)
                Text("Delete Account")
                Spacer()
            }
            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
            .foregroundStyle(.linearGradient(colors: [
                Color(theme.lightRed),
                Color(theme.darkRed)
            ], startPoint: .top, endPoint: .bottom))
        }
    }
}
