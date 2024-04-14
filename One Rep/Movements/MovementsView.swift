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
    
    @EnvironmentObject var theme: ThemeModel
    @ObservedRealmObject var movementModel: MovementViewModel
    
    @State private var showAddMovementPopup = false
    @State private var selectedMovement: Movement?
    @State private var menuSelection = "All"
    @State private var searchText = ""

    /// Search Bar
    var filteredMovements: Results<Movement> {
        if searchText.isEmpty {
            return movementModel.movements.sorted(by: \Movement.name, ascending: true)
        } else {
            let filteredMovements = movementModel.movements.sorted(by: \Movement.name, ascending: true).where {
                $0.name.contains(searchText, options: .diacriticInsensitive)
            }
            return filteredMovements
        }
    }
    
    var body: some View {
        NavigationView {            
            ZStack {
                Color(theme.BackgroundColor)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        HorizontalScroller(muscleSelection: $menuSelection)
                        ForEach(filteredMovements) { movement in
                            if (movement.muscleGroup == menuSelection) || (menuSelection == "All") {
                                MovementCardButton(movement: movement, selectedMovement: $selectedMovement)
                            }
                        }
                    }
                    .sheet(isPresented: $showAddMovementPopup) {
                        AddMovementView(movementModel: movementModel)
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Movements")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    AddMovementCardButton(showAddMovementPopup: $showAddMovementPopup)
                }
            })
        }
    }
}

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
