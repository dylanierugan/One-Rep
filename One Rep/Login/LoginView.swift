//
//  LoginView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            VStack(spacing: 16) {
                VStack(spacing: 8) {
                    OneRepLogo(size: .title)
                    Text("Do one more rep than last time")
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                }
                SignInWithApple()
                    .frame(height: 32)
                    .padding(.top, 8)
                    .padding(.horizontal, 32)
            }
        }
        .onAppear() {
            if Auth.auth().currentUser != nil {
                viewRouter.currentPage = .loadDataView
            }
        }
    }
}
