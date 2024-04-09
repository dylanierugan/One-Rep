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
    @EnvironmentObject var themeColor: ThemeColorModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSecure = true
    @State var isLoggingIn = false
    @State var showResetPassword = false
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            Color(themeColor.Background)
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack(spacing: 8) {
                    RepsLogo(size: 28)
                    Text("Do one more rep than last time")
                        .font(.caption.weight(.regular))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                }
                Spacer()
                SignInWithApple(isLoggingIn: isLoggingIn)
                    .frame(height: 32)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
            }
        }
    }
}
