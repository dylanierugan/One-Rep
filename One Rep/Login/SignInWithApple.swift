//
//  SignInWithApple.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import AuthenticationServices
import SwiftUI

struct SignInWithApple: View {
    
    // MARK: - Variables
    
    @Environment(\.colorScheme) var currentScheme
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var identityTokenString = ""
    
    // MARK: - View
    
    var body: some View {
        VStack {
            SignInWithAppleButton(.signIn, onRequest: { request in
                AppleSignInManager.shared.requestAppleAuthorization(request)
            }, onCompletion: { result in
                handleAppleID(result)
            })
            .signInWithAppleButtonStyle(currentScheme == .light ? .black : .white)
            .cornerRadius(16)
        }
    }
    
    func handleAppleID(_ result: Result<ASAuthorization, Error>) {
        if case let .success(auth) = result {
            guard let appleIDCredentials = auth.credential as? ASAuthorizationAppleIDCredential else {
                print("AppleAuthorization failed: AppleID credential not available")
                /// TODO - Error handle
                return
            }
            Task {
                do {
                    let result = try await authManager.appleAuth(
                        appleIDCredentials,
                        nonce: AppleSignInManager.nonce
                    )
                    if result != nil {
                        viewRouter.currentPage = .tabView
                    }
                } catch {
                    print("AppleAuthorization failed: \(error)")
                    /// TODO - Error handle
                }
            }
        }
        else if case let .failure(error) = result {
            print("AppleAuthorization failed: \(error)")
            /// TODO - Error handle
        }
    }
}
