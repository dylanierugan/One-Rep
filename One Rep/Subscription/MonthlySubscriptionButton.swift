//
//  MonthlySubscriptionButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 10/12/24.
//

import SwiftUI

struct MonthlySubscriptionButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    @ObservedObject var subscriptionViewModel: SubscriptionViewModel
    
    // MARK: - View
    
    var body: some View {
        Button {
            withAnimation {
                subscriptionViewModel.subscriptionChoice = .monthly
            }
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Monthly")
                        .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                        .foregroundStyle(.primary)
                    
                    Text("$3.99 a month")
                        .customFont(size: .body, weight: .regular, kerning: 0, design: .rounded)
                        .foregroundStyle(subscriptionViewModel.subscriptionChoice == .monthly ? Color("LightGreen") : .secondary)
                    
                    Text("")
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
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(subscriptionViewModel.subscriptionChoice == .monthly ? Color(Colors.LightGreen.rawValue) : .clear, lineWidth: 2)
            )
        }
        .padding(.horizontal, 20)
        .padding(.top, 32)
    }
}
