//
//  YearlySubscriptionButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 10/12/24.
//

import SwiftUI

struct YearlySubscriptionButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    @ObservedObject var subscriptionViewModel: SubscriptionViewModel
    
    // MARK: - View
    
    var body: some View {
        Button {
            withAnimation {
                subscriptionViewModel.subscriptionChoice = .yearly
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 120)
                    .foregroundStyle(subscriptionViewModel.subscriptionChoice == .yearly ? Color(Colors.LightGreen.rawValue) : .clear)
                    .padding(.horizontal, -2)
                if subscriptionViewModel.subscriptionChoice == .yearly {
                    Text(SubscriptionStrings.DiscountPercent.rawValue)
                        .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                        .foregroundStyle(.black)
                        .padding(.bottom, 92)
                }
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Yearly")
                            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            .foregroundStyle(.primary)
                        
                        Text("$24.99 a year")
                            .customFont(size: .body, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundStyle(subscriptionViewModel.subscriptionChoice == .yearly ? Color(Colors.LightGreen.rawValue) : .secondary)
                        
                        Text("7 day free trial")
                            .customFont(size: .body, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundStyle(.primary)
                        
                    }
                    Spacer()
                }
                .foregroundStyle(Color(.customPrimary))
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(Color(theme.backgroundElementColor))
                .cornerRadius(12)
                .foregroundColor(.white)
                .padding(.top, 24)
            }
        }
        .padding(.horizontal, 20)
    }
}
