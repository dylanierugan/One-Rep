//
//  EditMovementView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/3/24.
//

import SwiftUI

struct EditMovementView: View {
    
    init(movement: Movement,
         showDoneToolBar: Binding<Bool>) {
        self.movement = movement
        _editMovementViewModel = StateObject(wrappedValue: EditMovementViewModel(movement: movement))
        _showDoneToolBar = showDoneToolBar
    }
        
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - Public Properties
    
    var movement: Movement
    @StateObject var editMovementViewModel: EditMovementViewModel
    
    @Binding var showDoneToolBar: Bool
    var muscleGroups: [MuscleGroup] = [.All, .Arms, .Back, .Chest, .Core, .Legs, .Shoulders]
    
    // MARK: - Private Properties
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                VStack(spacing: 24) {
                    Text(EditMovementStrings.EditMovement.rawValue)
                        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(EditMovementStrings.EditName.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        MovementNameTextField(focus: false, movementName: $editMovementViewModel.newMovementName,
                                              text: editMovementViewModel.movement.name)
                    }
                    .padding(.horizontal, 16)
                    MovementTypePicker(movementTypeSelection: $editMovementViewModel.newMovementType,
                                       captionText: EditMovementStrings.EditMovementType.rawValue)
                        .padding(.horizontal, 16)
                    VStack(alignment: .leading,  spacing: 4) {
                        Text(EditMovementStrings.EditMuscleGroup.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        MusclePicker(muscleGroup: $editMovementViewModel.newMuscleGroup)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 24)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        if editMovementViewModel.showDeletingMovementProgressView {
                            ProgressView()
                        } else {
                            DeleteMovementButton(deleteConfirmedClicked:
                                                    $editMovementViewModel.deleteConfirmedClicked,
                                                 showingDeleteMovementAlert:
                                                    $editMovementViewModel.showingDeleteMovementAlert,
                                                 deleteMovementInFirebase: {
                                Task {
                                    await deleteMovement()
                                }
                            })
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        if editMovementViewModel.showEditingMovementProgressView {
                            ProgressView()
                        } else {
                            UpdateMovementButton(updateMovementInFirebase: {
                                Task {
                                    await editMovement()
                                }
                            })
                        }
                    }
                })
            }
            .onAppear { editMovementViewModel.setEditableAttributes() }
            .onDisappear { showDoneToolBar = true }
        }
    }
    
    // MARK: - Functions
    
    private func editMovement() async {
        await editMovementViewModel.updateMovementAttributes(userId: userViewModel.userId)
        movementsViewModel.updateMovementInList(editMovementViewModel.movement)
        dismiss()
    }
    
    private func deleteMovement() async {
        await editMovementViewModel.deleteMovement(userId: userViewModel.userId)
        await logsViewModel.deleteAllMovementLogs(userId: userViewModel.userId, movement: editMovementViewModel.movement)
        movementsViewModel.deleteMovementInList(editMovementViewModel.movement)
        dismiss()
    }
}
