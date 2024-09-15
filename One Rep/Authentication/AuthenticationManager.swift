//
//  AuthenticationManager.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/27/24.
//

import AuthenticationServices
import FirebaseAuth
import FirebaseCore

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let isAnonymous: Bool
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
    }
}

@MainActor
class AuthenticationManager: ObservableObject {
    
    // MARK: - Properties
    
    @Published var user: User?
    
    static let shared = AuthenticationManager()
    private init() { }
    
    // MARK: - User Functions
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            // TODO: Error handle
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func signOut() async throws {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
            }
            catch let error as NSError {
                // TODO: Handle error
                throw error
            }
        }
    }
    
    func deleteUser() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
            // TODO: Error handle
        }
        try await user.delete()
    }
    
}

extension AuthenticationManager {
        
    @discardableResult
    func signInWithApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel {
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokens.token, rawNonce: tokens.nonce)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
}
