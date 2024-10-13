//
//  SubscriptionTermsButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 10/12/24.
//

import SwiftUI

struct SubscriptionTermsButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    @ObservedObject var subscriptionViewModel: SubscriptionViewModel
    
    // MARK: - View
    
    var body: some View {
        Button {
            subscriptionViewModel.showTermsPopup = true
        } label: {
            Text(SubscriptionStrings.TermsAndConditions.rawValue)
                .customFont(size: .body, weight: .bold, design: .rounded)
                .foregroundStyle(Color(theme.lightBaseColor))
        }
    }
}
