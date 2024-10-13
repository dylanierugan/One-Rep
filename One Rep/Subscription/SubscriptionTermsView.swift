//
//  SubscriptionTermsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 10/12/24.
//

import SwiftUI

struct SubscriptionTermsView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Text(SubscriptionTermStrings.TermTitle.rawValue)
                        .customFont(size: .title, weight: .bold, design: .rounded)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 32)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(SubscriptionTermStrings.TermBilling.rawValue)
                            .customFont(size: .body, weight: .regular, design: .rounded)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                        Text(SubscriptionTermStrings.TermUnlimitedAccess.rawValue)
                            .customFont(size: .body, weight: .regular, design: .rounded)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                        Text(SubscriptionTermStrings.TermUnsubscribe.rawValue)
                            .customFont(size: .body, weight: .regular, design: .rounded)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                        Text(SubscriptionTermStrings.TermResubscribe.rawValue)
                            .customFont(size: .body, weight: .regular, design: .rounded)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                    }
                    Text(SubscriptionTermStrings.TermQuestions.rawValue)
                        .customFont(size: .caption, weight: .regular, design: .rounded)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 32)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 48)
        }
    }
}
