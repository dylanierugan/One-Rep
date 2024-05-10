//
//  LoginView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI
import RealmSwift
import Realm
import AuthenticationServices

struct LoginView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var app: RealmSwift.App
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var theme: ThemeModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSecure = true
    @State private var isLoggingIn = false
    @State private var showResetPassword = false
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            VStack(spacing: 8) {
                RepsLogo(size: 28)
                Text("Do one more rep than last time")
                    .font(.caption.weight(.regular))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                SignInWithApple(isLoggingIn: isLoggingIn)
                    .frame(height: 32)
                    .padding(.top, 8)
                    .padding(.horizontal, 32)
            }
        }
    }
}
