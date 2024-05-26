//
//  UserController.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/25/24.
//

import Foundation
import RealmSwift
import SwiftUI
import Realm

class AuthService: ObservableObject {
    
    func login(app: RealmSwift.App, identityTokenString: String, completion: @escaping (Result<User, Error>) -> Void) {
        var credentials: Credentials
        if !identityTokenString.isEmpty {
            credentials = Credentials.apple(idToken: identityTokenString)
        } else {
            credentials = Credentials.anonymous
        }
        app.login(credentials: credentials) { result in
            switch result {
            case .failure(let error):
                print("Login to Realm failed: \(error.localizedDescription)")
                completion(.failure(error))
            case .success(let user):
                DispatchQueue.main.async {
                    completion(.success(user))
                    print("Successfully logged into Realm as \(user.id).")
                }
            }
        }
    }
    

    func logOutUser(app: RealmSwift.App, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = app.currentUser else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "No user is currently logged in"])))
            return
        }
        user.logOut { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to log out: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                    print("Successfully logged out.")
                }
            }
        }
    }
    
    
    func deleteUser(app: RealmSwift.App, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = app.currentUser else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "No user is currently logged in"])))
            return
        }
        user.delete { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to delete user: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                    print("Successfully deleted user.")
                }
            }
        }
    }
}
