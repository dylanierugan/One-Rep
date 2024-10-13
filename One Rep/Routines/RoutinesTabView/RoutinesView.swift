//
//  RoutinesView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/21/24.
//

import SwiftUI

struct RoutinesView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var routinesViewModel: RoutinesViewModel
    
    // MARK: - Private Properties
    
    @State private var showAddRoutinePopup = false
    
    private var sortedRoutines: [Routine] {
        return routinesViewModel.routines.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        }
    }
    
    // MARK: - View
    
    var body: some View {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                ScrollView {
                    if routinesViewModel.routines.count == 0 {
                        Text(InfoText.CreateNewRoutine.rawValue)
                            .customFont(size: .body, weight: .semibold, kerning: 0.5, design: .rounded)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 36)
                            .padding(.top, 32)
                    } else {
                        VStack(spacing: 16) {
                            ForEach(sortedRoutines, id: \.id) { routine in
                                RoutineCard(routine: routine)
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddRoutinePopup) {
                if routinesViewModel.routineCapReached {
                    SubscriptionView(subscriptionViewModel: SubscriptionViewModel(userCap: .routine,                 prompted: true, subscriptionChoice: .yearly))
                        .environment(\.sizeCategory, .extraSmall)
                        .environment(\.colorScheme, theme.colorScheme)
                } else {
                    AddRoutineView()
                        .environment(\.sizeCategory, .extraSmall)
                        .environment(\.colorScheme, theme.colorScheme)
                }
            }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                AddRoutineToolButton(showAddRoutinePopup: $showAddRoutinePopup)
            }
        })
    }
}
