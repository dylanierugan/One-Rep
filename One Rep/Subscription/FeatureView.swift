//
//  FeatureView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 10/12/24.
//

import SwiftUI

struct FeatureView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    var featureName: String
    var icon: String
    var isFree: Bool
    var released: Bool
    
    // MARK: - View
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.caption.bold())
                .foregroundStyle(.secondary)
                .frame(width: 8, height: 8)
                .padding(.trailing, 8)
            Text(featureName)
            if !released {
                HStack {
                    Text(SubscriptionStrings.ComingSoong.rawValue)
                        .customFont(size: .caption, weight: .bold, design: .rounded)
                        .foregroundStyle(Color(Colors.LightGreen.rawValue))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .background(Color(Colors.LightGreen.rawValue).opacity(0.2))
                        .cornerRadius(12)
                    Spacer()
                }
                .padding(.leading, 8)
            }
            Spacer()
            if isFree {
                CheckMarkSubscriptionView(color: released ? Color(Colors.LightGreen.rawValue) : .secondary)
                    .padding(.trailing, 56)
            }
            CheckMarkSubscriptionView(color: released ? Color(Colors.LightGreen.rawValue) : .secondary)
                .padding(.trailing, 22)
        }
    }
}
