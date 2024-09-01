//
//  MovementsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/29/24.
//

import SwiftUI
import UIKit

struct MovementsView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    
    // MARK: - Private Properties
    
    @State private var menuSelection: MuscleGroup = .All
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 16) {
            HorizontalScroller(muscleSelection: $menuSelection)
            ForEach(movementsViewModel.filteredMovements, id: \.id) { movement in
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
    }
}

