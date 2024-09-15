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
    
    @State private var movementName = ""
    @State private var muscleGroup: MuscleGroup = .Arms
    @State private var movementType: MovementType = .Weight
    @State private var showProgressView = false
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid: Bool {
        !movementName.isEmpty
    }
    
    // MARK: - View
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                VStack(spacing: 36) {
                    
                    Text(AddMovementStrings.NewMovement.rawValue)
                        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(AddMovementStrings.MovementName.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        MovementNameTextField(focus: true, movementName: $movementName, text: "")
                    }
                    .padding(.horizontal, 16)
                    
                    MovementTypePicker(movementTypeSelection: $movementType, captionText: AddMovementStrings.MovementType.rawValue)
                        .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading,  spacing: 6) {
                        Text(AddMovementStrings.MuscleGroup.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        MusclePicker(muscleGroup: $muscleGroup)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 24)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        if showProgressView {
                            ProgressView()
                        } else {
                            AddMovementButton(isFormValid: isFormValid, addMovementToFirebase: {
                                addMovement(newMovement: createAndReturnMovement())
                            })
                        }
                    }
                }
            } .onAppear { setMuscleGroup() }
        }
    }
    
    // MARK: - Functions
    
    private func setMuscleGroup() {
        if movementsViewModel.currentMuscleSelection != .All {
            muscleGroup = movementsViewModel.currentMuscleSelection
        }
    }
    
    private func createAndReturnMovement() -> Movement {
        let docId = UUID().uuidString
        let newMovement = Movement(id: docId,
                                   userId: userViewModel.userId,
                                   name: movementName,
                                   muscleGroup: muscleGroup,
                                   movementType: movementType,
                                   timeAdded: Date.now.timeIntervalSince1970,
                                   isPremium: false,
                                   mutatingValue: 5.0)
        return newMovement
    }
    
    private func addMovement(newMovement: Movement) {
        Task {
            let result = await movementsViewModel.addMovement(newMovement)
            ResultHandler.shared.handleResult(result: result, onSuccess: {
                showProgressView = false
                dismiss()
            })
        }
    }
}
