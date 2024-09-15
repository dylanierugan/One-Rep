//
//  LoginView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Spacer()
                
                VStack(spacing: 8) {
                    OneRepLogo(size: .title)
                    Text(LoginStrings.DeleteMovmentConfirmation.rawValue)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                }
                
                SignInWithAppleView()
                    .padding(.top, 8)
                    .padding(.horizontal, 32)
                
                Spacer()
                
                Link(PrivacyPolicy.Text.rawValue, destination: URL(string: PrivacyPolicy.Link.rawValue)!)
                    .customFont(size: .caption, weight: .bold, design: .rounded)
                    .foregroundColor(.primary)
                    .padding(.bottom, 16)
            }
        }
        .onAppear { onAppearSetViewRouter() }
    }
    
    // MARK: - Functions
    
    private func onAppearSetViewRouter() {
        if let _ = Auth.auth().currentUser {
            viewRouter.currentPage = .loadDataView
        }
    }
}
