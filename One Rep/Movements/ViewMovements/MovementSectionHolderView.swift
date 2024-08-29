//
//  MovementSectionHolderView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI
import UIKit

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
                AddMovementView()
                    .environment(\.sizeCategory, .extraSmall)
                    .environment(\.colorScheme, theme.colorScheme)
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
