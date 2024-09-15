//
//  AuthenticationViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/13/24.
//

import Foundation

import Foundation

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInWithApple() async throws -> UserModel {
        let helper = AppleSignInHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
        return UserModel(auth: authDataResult)
    }

}
