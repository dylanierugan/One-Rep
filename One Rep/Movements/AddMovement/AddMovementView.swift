//
//  AddMovementView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import SwiftUI

struct AddMovementView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    @EnvironmentObject var routinesViewModel: RoutinesViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - Private Properties
    
    @StateObject private var addMovementViewModel = AddMovementViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - View
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                VStack(spacing: 24) {
                    
                    Text(AddMovementStrings.NewMovement.rawValue)
                        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(AddMovementStrings.MovementName.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        MovementNameTextField(focus: true, movementName: $addMovementViewModel.movementName, text: "")
                    }
                    .padding(.horizontal, 16)
                    
                    MovementTypePicker(movementTypeSelection: $addMovementViewModel.movementType, captionText: AddMovementStrings.MovementType.rawValue)
                        .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading,  spacing: 6) {
                        Text(AddMovementStrings.MuscleGroup.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        MusclePicker(muscleGroup: $addMovementViewModel.muscleGroup)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 24)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        if addMovementViewModel.showAddingMovementProgressView {
                            ProgressView()
                        } else {
                            AddMovementButton(isFormValid: addMovementViewModel.isFormValid, addMovementToFirebase: {
                                Task {
                                    await addMovement()
                                }
                            })
                        }
                    }
                }
            }
            .onAppear { setMuscleGroup() }
        }
    }
    
    // MARK: - Functions
    
    private func setMuscleGroup() {
        if movementsViewModel.currentMuscleSelection != .All {
            addMovementViewModel.muscleGroup = movementsViewModel.currentMuscleSelection
        }
    }
    
    private func addMovement() async {
        let newMovement = await addMovementViewModel.addMovement(userId: userViewModel.userId, addMovementViewModel: addMovementViewModel)
        guard let newMovement = newMovement else { return }
        movementsViewModel.movements.append(newMovement)
        dismiss()
    }
}
