//
//  SubscribeButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 10/12/24.
//

import SwiftUI

struct SubscribeButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - View
    
    var body: some View {
        Button {
            
        } label: {
            HStack {
                Spacer()
                Text(SubscriptionStrings.Subscribe.rawValue)
                    .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                    .foregroundStyle(.customPrimary)
                Spacer()
            }
            .padding(.vertical, 12)
            .background(Color(theme.backgroundElementColor))
            .cornerRadius(16)
        }
    }
}
