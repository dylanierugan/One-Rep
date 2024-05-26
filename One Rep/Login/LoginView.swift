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
        
    @EnvironmentObject var app: RealmSwift.App
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var theme: ThemeModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSecure = true
    @State private var showResetPassword = false
    
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
    }
}
