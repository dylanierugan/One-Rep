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
    @State private var showAddMovementPopup = false
    @State private var selectedMovement: Movement?
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    AddMovementCardButton(showAddMovementPopup: $showAddMovementPopup)
                    ForEach(movementModel.movements) { movement in
                        MovementCard(movement: movement, selectedMovement: $selectedMovement)
                    }
                }
                .padding(.vertical, 16)
                .sheet(isPresented: $showAddMovementPopup) {
                    AddMovementView(movementModel: movementModel)
                        .dynamicTypeSize(.xSmall)
                }
            }
        }
    }
}
