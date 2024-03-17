//
//  SignInWithApple.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import AuthenticationServices
import RealmSwift
import SwiftUI

struct SignInWithApple: View {
    
    @EnvironmentObject var app: RealmSwift.App
    @EnvironmentObject var viewRouter: ViewRouter
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var isLoggingIn: Bool
    @State var identityTokenString = ""
    
    var body: some View {
        VStack {
            SignInWithAppleButton(.signIn, onRequest: { request in
                isLoggingIn = true
                request.requestedScopes = [.email]
            }, onCompletion: { result in
                switch result {
                case .success(let authResults):
                    guard let credentials = authResults.credential as? ASAuthorizationAppleIDCredential, let identityToken = credentials.identityToken,
                            let identityTokenString = String(data: identityToken, encoding: .utf8) else { return }
                    self.identityTokenString = identityTokenString
                    print("Successfully signed in with Apple.")
                    login()
                case .failure(let error):
                    isLoggingIn = false
                    print("Sign in with Apple failed: \(error.localizedDescription)")
                }
            })
            .signInWithAppleButtonStyle(.white)
            .disabled(isLoggingIn)
        }
    }
    
    private func login() -> Void {
           var credentials: Credentials
           if self.identityTokenString != "" {
               credentials = Credentials.apple(idToken: identityTokenString)
           } else {
               credentials = Credentials.anonymous
           }
           app.login(credentials: credentials) { result in
               switch result {
               case .failure(let error):
                   print("Login to Realm failed: \(error.localizedDescription)")
               case .success(let user):
                   viewRouter.currentPage = .main
                   print("Successfully logged into Realm as \(user.id).")
               }
               isLoggingIn = false
           }
       }
    
}

