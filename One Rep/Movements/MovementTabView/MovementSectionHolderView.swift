//
//  MovementSectionHolderView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI

struct MovementSectionHolderView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    
    // MARK: - Private Properties
    
    @State private var movementSelection: MovementSelection = .Library
    @State private var selectedMovement: Movement?
    @State private var showAddMovementPopup = false
    @State private var showAddRoutinePopup = false
    
    private var navigationTitle: String {
        switch movementSelection {
        case .Activity:
            return NavigationTitleStrings.Activity.rawValue
        case .Routines:
            return NavigationTitleStrings.Routines.rawValue
        case .Library:
            return NavigationTitleStrings.Library.rawValue
        }
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        MovementSelectionPicker(movementSelection: $movementSelection)
                            .padding(.horizontal, 16)
                        switch movementSelection {
                        case .Library:
                            VStack {
                                MovementsView()
                            }
                        case .Activity:
                            VStack {
                                 ActivityView()
                            }
                        case .Routines:
                            VStack {
                                RoutinesView()
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddMovementPopup) {
                if movementsViewModel.movementCapReached {
                    SubscriptionView(subscriptionViewModel: SubscriptionViewModel(userCap: .movement,                 prompted: true, subscriptionChoice: .yearly))
                        .environment(\.sizeCategory, .extraSmall)
                        .environment(\.colorScheme, theme.colorScheme)
                } else {
                    AddMovementView()
                        .environment(\.sizeCategory, .extraSmall)
                        .environment(\.colorScheme, theme.colorScheme)
                }
            }
            .navigationTitle(navigationTitle)
            .toolbar(content: {
                if movementSelection == .Library {
                    ToolbarItem(placement: .topBarTrailing) {
                        AddMovementToolButton(showAddMovementPopup: $showAddMovementPopup)
                    }
                }
                ToolbarItem(placement: .principal) {
                    HStack{
                        Text(LogoString.OneRep.rawValue)
                            .customFont(size: .body, weight: .bold, kerning: 0.5, design: .rounded)
                    }
                }
            })
        }
    }
}
