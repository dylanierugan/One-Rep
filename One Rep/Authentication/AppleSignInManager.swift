//
//  AppleSignInManager.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/27/24.
//

import AuthenticationServices
import CryptoKit

class AppleSignInManager {
    
    static let shared = AppleSignInManager()
    
    fileprivate static var currentNonce: String?
    
    // MARK: - Computed Properties
    
    static var nonce: String? {
        currentNonce ?? nil
    }
    
    // MARK: - Init

    private init() {}
    
    // MARK: - Public Functions

    func requestAppleAuthorization(_ request: ASAuthorizationAppleIDRequest) {
        AppleSignInManager.currentNonce = randomNonceString()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(AppleSignInManager.currentNonce!)
    }
}

// MARK: - Extension

extension AppleSignInManager {

    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            // TODO: Handle error
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }

        let charset: [Character] =
        Array(AppleSignInManagerStrings.CharSet.rawValue)

        let nonce = randomBytes.map { byte in
            charset[Int(byte) % charset.count]
        }

        return String(nonce)
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: AppleSignInManagerStrings.Format.rawValue, $0)
        }.joined()

        return hashString
    }
}
