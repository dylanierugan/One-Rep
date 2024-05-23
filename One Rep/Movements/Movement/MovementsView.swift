//
//  MovementsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI
import RealmSwift
import UIKit

struct MovementsView: View {
    
    // MARK: - Variables
    
    @Environment(\.dismissSearch) private var dismissSearch
    @EnvironmentObject var theme: ThemeModel
    
    @ObservedRealmObject var movementViewModel: MovementViewModel
    
    @State private var searchText = ""
    @State private var movementSelection: MovementSelection = .Library
    @State private var menuSelection: MuscleType = .All
    @State private var selectedMovement: Movement?
    @State private var showAddMovementPopup = false
    
    /// Search Bar
    private var filteredMovements: Results<Movement> {
        if searchText.isEmpty {
            return movementViewModel.movements.sorted(by: \Movement.name, ascending: true)
        } else {
            let filteredMovements = movementViewModel.movements.sorted(by: \Movement.name, ascending: true).where {
                $0.name.contains(searchText, options: .diacriticInsensitive)
            }
            return filteredMovements
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
                                ForEach(filteredMovements) { movement in
                                    if (movement.muscleGroup == menuSelection) || (menuSelection == .All) {
                                        MovementCardButton(movementViewModel: movementViewModel, selectedMovement: $selectedMovement, movement: movement)
                                    }
                                }
                                if (movementViewModel.movements.count == 0) || (menuSelection != .All && movementViewModel.movements.filter({$0.muscleGroup == menuSelection}).count == 0) {
                                    Text(InfoText.CreateNewMovement.description)
                                        .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.secondary)
                                        .padding(.horizontal, 36)
                                        .padding(.top, 16)
                                }
                            }
                        case .Activity:
                            VStack {
                                ActivityView(movementViewModel: movementViewModel)
                            }
                        }
                    }
                    .sheet(isPresented: $showAddMovementPopup) {
                        AddMovementView(movementViewModel: movementViewModel)
                            .environment(\.sizeCategory, .extraSmall)
                    }
                }
            }
            .navigationTitle("Movements")
            .toolbar(content: {
                if movementSelection == .Library {
                    ToolbarItem(placement: .topBarTrailing) {
                        AddMovementCardButton(showAddMovementPopup: $showAddMovementPopup)
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
