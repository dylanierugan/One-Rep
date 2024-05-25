//
//  LogOutButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI
import RealmSwift

struct LogOutButton: View {
    
    @EnvironmentObject var app: RealmSwift.App
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var viewRouter: ViewRouter
    
    // MARK: - View
    
    var body: some View {
        Button {
            authService.logOutUser { result in
                switch result {
                case .failure(let error):
                    /// Handle error
                    print("Log out failed: \(error.localizedDescription)")
                case .success:
                    withAnimation {
                        viewRouter.currentPage = .login
                    }
                }
            }
        } label: {
            HStack(spacing: 16) {
                Image(systemName: Icons.RectanglePortraitAndArrowRight.description)
                Text("Log Out")
                Spacer()
            }
            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
            .foregroundStyle(.linearGradient(colors: [
                Color(theme.lightBaseColor),
                Color(theme.darkBaseColor)
            ], startPoint: .top, endPoint: .bottom))
        }
    }
}
