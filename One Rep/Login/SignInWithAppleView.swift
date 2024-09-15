//
//  SignInWithAppleView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import AuthenticationServices
import SwiftUI

struct SignInWithAppleView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - Private Properties
   
    @Environment(\.colorScheme) private var currentScheme
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Button {
                Task {
                    do {
                        let user = try await authenticationViewModel.signInWithApple()
                        try await userViewModel.userManager.createNewUser(user: user)
                        viewRouter.currentPage = .loadDataView
                    } catch {
                        // TODO: Handle error
                    }
                }
            } label: {
                SignInWithAppleButtonViewRepresentable(type: .default, style: currentScheme == .light ? .black : .white)
                    .allowsHitTesting(false)
                    .frame(height: 32)
                    .cornerRadius(16)
            }
        }
    }
}
