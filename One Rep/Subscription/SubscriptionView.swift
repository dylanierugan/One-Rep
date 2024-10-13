//
//  SubscriptionView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 10/12/24.
//

import SwiftUI

struct SubscriptionView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    @StateObject var subscriptionViewModel: SubscriptionViewModel
    
    // MARK: - View
    
    var body: some View {
        ScrollView {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                
                VStack(spacing: 32) {
                    Spacer()
                    
                    if subscriptionViewModel.prompted {
                        switch subscriptionViewModel.userCap {
                        case .none:
                            EmptyView()
                        case .movement:
                            Text(SubscriptionStrings.MovementCap.rawValue)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                                .customFont(size: .body, weight: .regular, design: .rounded)
                        case .routine:
                            Text(SubscriptionStrings.RoutineCap.rawValue)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                                .customFont(size: .body, weight: .regular, design: .rounded)
                        }
                        
                    }
                    
                    VStack {
                        Text(SubscriptionStrings.UpgradeTo.rawValue)
                            .customFont(size: .body, weight: .bold, design: .rounded)
                        Text(SubscriptionStrings.OneRepUnlimited.rawValue)
                            .customFont(size: .title, weight: .bold, design: .rounded)
                    }
                    
                    VStack {
                        HStack(spacing: 24) {
                            Spacer()
                            Text(SubscriptionStrings.Free.rawValue)
                                .customFont(size: .body, weight: .bold, design: .rounded)
                                .padding(.bottom, 12)
                            Text(SubscriptionStrings.Member.rawValue)
                                .customFont(size: .body, weight: .bold, design: .rounded)
                                .padding(.bottom, 12)
                        }
                        
                        FeatureView(featureName: SubscriptionStrings.MovementTracking.rawValue,
                                    icon: Icons.DumbellFill.rawValue,
                                    isFree: true,
                                    released: true)
                        
                        Divider()
                        
                        FeatureView(featureName: SubscriptionStrings.RoutineTracking.rawValue,
                                    icon: Icons.ListBullet.rawValue,
                                    isFree: true,
                                    released: true)
                        
                        Divider()
                        
                        FeatureView(featureName: SubscriptionStrings.ActivityHistory.rawValue,
                                    icon: Icons.Calendar.rawValue,
                                    isFree: true,
                                    released: true)
                        
                        Divider()
                        
                        HStack {
                            FeatureView(featureName: SubscriptionStrings.Charts.rawValue,
                                        icon: Icons.ChartXYAxis.rawValue,
                                        isFree: true,
                                        released: false)
                        }
                        
                        Divider()
                        
                        HStack {
                            FeatureView(featureName: SubscriptionStrings.Movements.rawValue,
                                        icon: Icons.Infinity.rawValue,
                                        isFree: false,
                                        released: true)
                        }
                        
                        Divider()
                        
                        HStack {
                            FeatureView(featureName: SubscriptionStrings.Routines.rawValue,
                                        icon: Icons.Infinity.rawValue,
                                        isFree: false,
                                        released: true)
                        }
                        
                    }
                    .padding(.horizontal, 16)
                    
                    HStack {
                        YearlySubscriptionButton(subscriptionViewModel: subscriptionViewModel)
                        MonthlySubscriptionButton(subscriptionViewModel: subscriptionViewModel)
                    }
                    
                    Spacer()
                    
                    SubscriptionTermsButton(subscriptionViewModel: subscriptionViewModel)
                    SubscribeButton()
                        .padding(.horizontal, 16)
                }
            }
            .sheet(isPresented: $subscriptionViewModel.showTermsPopup) {
                SubscriptionTermsView()
            }
        }
        .background(Color(theme.backgroundColor))
    }
}
