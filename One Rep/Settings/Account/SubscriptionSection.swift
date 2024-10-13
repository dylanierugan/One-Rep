//
//  SubscriptionSection.swift
//  One Rep
//
//  Created by Dylan Ierugan on 10/13/24.
//

import SwiftUI

struct SubscriptionSection: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var isSubscribed = true
    @State var showSubscriptionPopup = false
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(SettingsStrings.Subscription.rawValue)
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary)
            if isSubscribed {
                NavigationLink {
                    SubscriptionStatusView()
                } label: {
                    VStack(alignment: .leading) {
                        HStack(spacing: 24) {
                            HStack(spacing: 16) {
                                Image(systemName: Icons.CrownFill.rawValue)
                                    .foregroundStyle(.linearGradient(colors: [.lightYellow, .lightYellow, .darkYellow], startPoint: .top, endPoint: .bottom))
                                Text(SettingsStrings.OneRepPremium.rawValue)
                            }
                            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            Spacer()
                            Image(systemName: Icons.ChevronRight.rawValue)
                                .font(.caption).bold()
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal, 16)
                    }
                    .frame(height: 48)
                    .background(Color(theme.backgroundElementColor))
                    .cornerRadius(16)
                }
            } else {
                Button {
                    showSubscriptionPopup = true
                } label: {
                    VStack(alignment: .leading) {
                        HStack(spacing: 24) {
                            HStack(spacing: 16) {
                                Image(systemName: Icons.CrownFill.rawValue)
                                    .foregroundStyle(.linearGradient(colors: [.lightYellow, .lightYellow, .darkYellow], startPoint: .top, endPoint: .bottom))
                                Text(SettingsStrings.Subscribe.rawValue)
                            }
                            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                    }
                    .frame(height: 48)
                    .background(Color(theme.backgroundElementColor))
                    .cornerRadius(16)
                }
            }
        }
        .sheet(isPresented: $showSubscriptionPopup) {
            SubscriptionView(subscriptionViewModel: SubscriptionViewModel(userCap: .none,
                                                                          prompted: false,
                                                                          subscriptionChoice: .yearly))
                .environment(\.sizeCategory, .extraSmall)
                .environment(\.colorScheme, theme.colorScheme)
        }
    }
}

#Preview {
    SubscriptionSection()
}
