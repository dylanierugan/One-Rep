//
//  SubscriptionStatusView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 10/13/24.
//

import SwiftUI

struct SubscriptionStatusView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            Text("Subscription Status")
                .customFont(size: .body, weight: .bold, design: .rounded)
        }
    }
}
