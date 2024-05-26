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
    
    // MARK: - Variables
    
    @Environment(\.colorScheme) var currentScheme
    @EnvironmentObject var app: RealmSwift.App
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var identityTokenString = ""
    
    // MARK: - View
    
    var body: some View {
        VStack {
            SignInWithAppleButton(.signIn, onRequest: { request in
                request.requestedScopes = [.email]
            }, onCompletion: { result in
                switch result {
                case .success(let authResults):
                    guard let credentials = authResults.credential as? ASAuthorizationAppleIDCredential, let identityToken = credentials.identityToken,
                          let identityTokenString = String(data: identityToken, encoding: .utf8) else { return }
                    self.identityTokenString = identityTokenString
                    print("Successfully signed in with Apple.")
                    authService.login(identityTokenString: identityTokenString) { result in
                        switch result {
                        case .failure(let error):
                            print(error.localizedDescription)
                        case .success:
                            withAnimation {
                                viewRouter.currentPage = .tabView
                            }
                        }
                    }
                case .failure(let error):
                    print("Sign in with Apple failed: \(error.localizedDescription)")
                }
            })
            .signInWithAppleButtonStyle(currentScheme == .light ? .black : .white)
            .cornerRadius(16)
        }
    }
}
