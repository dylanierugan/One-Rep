//
//  EditMovementView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/3/24.
//

import SwiftUI

struct EditMovementView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var errorHandler: ErrorHandler
    @ObservedObject var movementViewModel = MovementViewModel()
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Public Properties
    
    @Binding var showDoneToolBar: Bool
    var muscleGroups: [MuscleGroup] = [.All, .Arms, .Back, .Chest, .Core, .Legs, .Shoulders]
    
    // MARK: - Private Properties
    
    @State private var newMovementName = ""
    @State private var newMovementType: MovementType = .Weight
    @State private var newMuscleGroup: MuscleGroup = .Arms
    @State private var deleteConfirmedClicked = false
    @State private var showingDeleteMovementAlert = false
    @State private var showEditProgressView = false
    @State private var showDeleteProgressView = false
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                VStack(spacing: 36) {
                    Text(EditMovementStrings.EditMovement.rawValue)
                        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(EditMovementStrings.EditName.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        MovementNameTextField(focus: false, movementName: $newMovementName, text: movementViewModel.movement.name)
                    }
                    .padding(.horizontal, 16)
                    MovementTypePicker(movementTypeSelection: $newMovementType, captionText: EditMovementStrings.EditMovementType.rawValue)
                        .padding(.horizontal, 16)
                    VStack(alignment: .leading,  spacing: 4) {
                        Text(EditMovementStrings.EditMuscleGroup.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        MusclePicker(muscleGroup: $newMuscleGroup)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 24)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        DeleteMovementButton(deleteConfirmedClicked: $deleteConfirmedClicked, showingDeleteMovementAlert: $showingDeleteMovementAlert, deleteMovementInFirebase: {
                            deleteMovement()
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        if showEditProgressView {
                            ProgressView()
                        } else {
                            UpdateMovementButton(updateMovementInFirebase: {
                                editMovement()
                            })
                        }
                    }
                })
            }
            .onAppear { setEditValues() }
            .onDisappear { showDoneToolBar = true }
        }
    }
    
    // MARK: - Functions
    
    private func setEditValues() {
        newMovementName = movementViewModel.movement.name
        newMovementType = movementViewModel.movement.movementType
        newMuscleGroup = movementViewModel.movement.muscleGroup
    }
    
    private func editMovement() {
        Task {
            showEditProgressView = true
            movementViewModel.movement.name = newMovementName
            movementViewModel.movement.movementType = newMovementType
            movementViewModel.movement.muscleGroup = newMuscleGroup
            let result = await movementViewModel.updateMovement()
            errorHandler.handleMovementUpdate(result: result, dismiss: dismiss)
        }
    }
    
    private func deleteMovement() {
        Task {
            showDeleteProgressView = true
            var result = await movementsViewModel.deleteMovement(docId: movementViewModel.movement.id)
            result = await logViewModel.deleteAllMovementLogs(movementId: movementViewModel.movement.id)
            errorHandler.handleMovementUpdate(result: result, dismiss: dismiss)
        }
    }
}
