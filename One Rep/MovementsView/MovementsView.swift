//
//  MovementsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI
import UIKit

struct MovementsView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    
    // MARK: - Private Properties
    
    @State private var searchText = ""
    @State private var movementSelection: MovementSelection = .Library
    @State private var menuSelection: MuscleGroup = .All
    @State private var selectedMovement: Movement?
    @State private var showAddMovementPopup = false
    
    private var filteredMovements: [Movement] {
        if searchText.isEmpty {
            return movementsViewModel.movements.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
        } else {
            return movementsViewModel.movements
                .filter { $0.name.range(of: searchText, options: [.caseInsensitive, .diacriticInsensitive]) != nil }
                .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
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
                            VStack(spacing: 16) {
                                HorizontalScroller(muscleSelection: $menuSelection)
                                ForEach(filteredMovements, id: \.id) { movement in
                                    if (movement.muscleGroup == menuSelection) || (menuSelection == .All) {
                                        MovementCardButton(movement: movement)
                                    }
                                }
                                if (movementsViewModel.movements.count == 0) || (menuSelection != .All && movementsViewModel.movements.filter({$0.muscleGroup == menuSelection}).count == 0) {
                                    Text(InfoText.CreateNewMovement.rawValue)
                                        .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.secondary)
                                        .padding(.horizontal, 36)
                                        .padding(.top, 16)
                                }
                            }
                        case .Activity:
                            VStack {
                                 ActivityView()
                            }
                        case .Routines:
                            VStack {
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddMovementPopup) {
                AddMovementView()
                    .environment(\.sizeCategory, .extraSmall)
            }
            .navigationTitle(MovementsStrings.Movements.rawValue)
            .toolbar(content: {
                if movementSelection == .Library {
                    ToolbarItem(placement: .topBarTrailing) {
                        AddMovementToolButton(showAddMovementPopup: $showAddMovementPopup)
                    }
                }
            })
        }
    }
}

// MARK: - Extensions

/// Allows for custom font on the navigation title
extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor  .white]
        
        let titleTextStyle = UIFont.TextStyle.body
        let largeTtitleTextStyle = UIFont.TextStyle.largeTitle
        let titleFont = UIFont.preferredFont(forTextStyle: titleTextStyle, compatibleWith: nil)
        let largeTtitle = UIFont.preferredFont(forTextStyle: largeTtitleTextStyle, compatibleWith: nil)
        
        if let descriptor = titleFont.fontDescriptor.withDesign(.rounded)?.withSymbolicTraits(.traitBold) {
            let customFont = UIFont(descriptor: descriptor, size: titleFont.pointSize)
            appearance.titleTextAttributes = [ .font : customFont]
        }
        if let descriptor = titleFont.fontDescriptor.withDesign(.rounded)?.withSymbolicTraits(.traitBold) {
            let customFont = UIFont(descriptor: descriptor, size: largeTtitle.pointSize)
            appearance.largeTitleTextAttributes = [ .font : customFont]
        }
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
    }
}

/// Removes navigation back buttont text
extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
