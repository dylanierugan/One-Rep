//
//  AuthManager.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/27/24.
//

import AuthenticationServices
import FirebaseAuth
import FirebaseCore

enum AuthState {
    case authenticated
    case signedIn
    case signedOut
}

@MainActor
class AuthManager: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var user: User?
    @Published var authState = AuthState.signedOut
    
    // MARK: - Private Properties
    
    private var authStateHandle: AuthStateDidChangeListenerHandle!
    
    // MARK: - Init
    
    init() {
        configureAuthStateChanges()
    }
    
    // MARK: - Public Functions
    
    func configureAuthStateChanges() {
        authStateHandle = Auth.auth().addStateDidChangeListener { auth, user in
            self.updateState(user: user)
        }
    }
    
    func removeAuthStateListener() {
        Auth.auth().removeStateDidChangeListener(authStateHandle)
    }
    
    func updateState(user: User?) {
        self.user = user
        let isAuthenticatedUser = user != nil
        let isAnonymous = user?.isAnonymous ?? false
        if isAuthenticatedUser {
            self.authState = isAnonymous ? .authenticated : .signedIn
        } else {
            self.authState = .signedOut
        }
    }
    
    func signOut() async throws {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
            }
            catch let error as NSError {
                /// TODO - Error handle
                throw error
            }
        }
    }
    
    func deleteUser() async throws {
        let user = Auth.auth().currentUser
        do {
            try await user?.delete()
        } catch let error {
            throw error
        }
    }
    
    func appleAuth(_ appleIDCredential: ASAuthorizationAppleIDCredential, nonce: String?) async throws -> AuthDataResult? {
        guard let nonce = nonce else {
            /// TODO - Error handle
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        guard let appleIDToken = appleIDCredential.identityToken else {
            /// TODO - Error handle - unable to fetch identity
            return nil
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            /// TODO - Error handle
            return nil
        }
        let credentials = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                       rawNonce: nonce,
                                                       fullName: appleIDCredential.fullName)
        do {
            return try await authenticateUser(credentials: credentials)
        }
        catch {
            /// TODO - Error handle
            throw error
        }
    }
    
    // MARK: - Private Functions
    
    private func authenticateUser(credentials: AuthCredential) async throws -> AuthDataResult? {
        return try await authSignIn(credentials: credentials)
    }
    
    private func authSignIn(credentials: AuthCredential) async throws -> AuthDataResult? {
        do {
            let result = try await Auth.auth().signIn(with: credentials)
            updateState(user: result.user)
            return result
        }
        catch {
            /// TODO - Error handle
            print(error)
            throw error
        }
    }
}
