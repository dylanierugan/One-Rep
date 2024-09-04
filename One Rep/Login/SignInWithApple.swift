//
//  SignInWithApple.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import AuthenticationServices
import SwiftUI

struct SignInWithApple: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var viewRouter: ViewRouter
    
    // MARK: - Private Properties
    
    @State private var identityTokenString = ""
    @Environment(\.colorScheme) private var currentScheme
    
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
    
    // MARK: - Public Functions
    
    func handleAppleID(_ result: Result<ASAuthorization, Error>) {
        if case let .success(auth) = result {
            guard let appleIDCredentials = auth.credential as? ASAuthorizationAppleIDCredential else {
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
                        viewRouter.currentPage = .loadDataView
                    }
                } catch {
                    /// TODO - Error handle
                }
            }
        }
        else if case let .failure(error) = result {
            /// TODO - Error handle
            print(error.localizedDescription)
        }
    }
}
