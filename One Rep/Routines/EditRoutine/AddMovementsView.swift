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
    @EnvironmentObject var routinesViewModel: RoutinesViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - Public Properties
    
    @ObservedObject var selectedRoutineViewModel: SelectedRoutineViewModel
    
    // MARK: - Private Properties
    
    @State private var movementsToAdd: [Movement] = []
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor).ignoresSafeArea()
            
            VStack(spacing: 36) {
                Text(selectedRoutineViewModel.routine.name)
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
                        ForEach(selectedRoutineViewModel.movementsToAdd, id: \.id) { movement in
                            VStack {
                                Divider()
                                HStack {
                                    Text(movement.name)
                                        .customFont(size: .body, weight: .bold, design: .rounded)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Button {
                                        Task {
                                            await addMovementTap(movementId: movement.id)
                                        }
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
        .onAppear { selectedRoutineViewModel.setMovementsToAddArray(movements: movementsViewModel.movements, dismissAction: {
                dismiss()
            })
        }
    }
    
    // MARK: - Functions
    
    private func addMovementTap(movementId: String) async {
        HapticManager.instance.impact(style: .soft)
        selectedRoutineViewModel.routine.movementIDs.append(movementId)
        await selectedRoutineViewModel.updateRoutineMovementsList(userId: userViewModel.userId)
        routinesViewModel.updateRoutineInList(selectedRoutineViewModel.routine)
        selectedRoutineViewModel.setMovementsToAddArray(movements: movementsViewModel.movements, dismissAction: {
            dismiss()
        })
        selectedRoutineViewModel.setMovements(userId: userViewModel.userId, movements: movementsViewModel.movements)
    }
}
