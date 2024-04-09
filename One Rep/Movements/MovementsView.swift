//
//  MovementsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI
import RealmSwift

struct MovementsView: View {
    
    @ObservedRealmObject var movementModel: MovementViewModel
    @EnvironmentObject var themeColor: ThemeColorModel
    
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
                Color(themeColor.Background)
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        HorizontalScroller(muscleSelection: $menuSelection)
                            .padding(.bottom, -16)
                        ForEach(filteredMovements) { movement in
                            if (movement.muscleGroup == menuSelection) || (menuSelection == "All") {
                                MovementCardButton(movement: movement, selectedMovement: $selectedMovement)
                            }
                        }
                        AddMovementCardButton(showAddMovementPopup: $showAddMovementPopup)
                    }
                    .sheet(isPresented: $showAddMovementPopup) {
                        AddMovementView(movementModel: movementModel)
                    }
                }
                .searchable(text: $searchText)
            }
        }
    }
}
