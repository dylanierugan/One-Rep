//
//  LogOutButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI
import RealmSwift

struct LogOutButton: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var app: RealmSwift.App
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    // MARK: - View
    
    var body: some View {
        Button {
            Task {
                logOutUser()
            }
        } label: {
            HStack {
                Spacer()
                Text("Log Out")
                Image(systemName: Icons.RectanglePortraitAndArrowRight.description)
                Spacer()
            }
            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
            .foregroundStyle(.linearGradient(colors: [
                Color(theme.lightBaseColor),
                Color(theme.darkBaseColor)
            ],startPoint: .top, endPoint: .bottom))
            .frame(height: 48)
            .background(Color(theme.backgroundElementColor))
            .cornerRadius(16)
        }
    }
    
    // MARK: - Functions
    
    private func logOutUser() {
        app.currentUser?.logOut { (error) in
            if error != nil {
                /// Handle error
            } else {
                DispatchQueue.main.async {
                    withAnimation {
                        viewRouter.currentPage = .login
                    }
                }
            }
        }
    }
}
