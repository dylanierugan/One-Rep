//
//  AddMovementsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/5/24.
//

import SwiftUI

struct AddMovementsView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    @EnvironmentObject var errorHandler: ErrorHandler
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Public Properties
    
    @ObservedObject var routineViewModel: RoutineViewModel
    
    // MARK: - Private Properties
    
    @State private var movementsToAdd: [Movement] = []
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor).ignoresSafeArea()
            
            VStack(spacing: 36) {
                Text(routineViewModel.routine.name)
                    .customFont(size: .title3, weight: .bold, design: .rounded)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 72)
                
                VStack {
                    HStack {
                        Text(RoutineStrings.MovementsToAdd.rawValue)
                            .customFont(size: .caption2, weight: .semibold, design: .rounded)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    ScrollView {
                        ForEach(movementsToAdd, id: \.id) { movement in
                            VStack {
                                Divider()
                                HStack {
                                    Text(movement.name)
                                        .customFont(size: .body, weight: .bold, design: .rounded)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Button {
                                        addMovementTap(movementId: movement.id)
                                    } label: {
                                        Image(systemName: Icons.TextBadgePlus.rawValue)
                                            .customFont(size: .body, weight: .bold, design: .rounded)
                                            .foregroundColor(colorScheme == .dark ? Color(theme.lightBaseColor) : Color(theme.darkBaseColor))
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .onAppear { setMovementsArray() }
        .onDisappear { routineViewModel.setMovements(movements: movementsViewModel.movements, errorHandler: errorHandler) }
    }
    
    // MARK: - Functions
    
    private func setMovementsArray() {
        movementsToAdd = []
        for movement in movementsViewModel.movements {
            if !routineViewModel.routine.movementIDs.contains(movement.id) {
                movementsToAdd.append(movement)
            }
        }
        if movementsToAdd.count == 0 {
            dismiss()
        }
    }
    
    private func addMovementTap(movementId: String) {
        HapticManager.instance.impact(style: .soft)
        routineViewModel.routine.movementIDs.append(movementId)
        Task {
            let result = await routineViewModel.updateRoutine()
            errorHandler.handleUpdateRoutine(result: result, dismiss: nil)
            setMovementsArray()
        }
    }
}
