//
//  EditMovementView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/3/24.
//

import SwiftUI

struct EditMovementView: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    
    @ObservedObject var movementViewModel = MovementViewModel()
    
    @State private var newMovementName = ""
    @State private var newMovementType: MovementType = .Weight
    @State private var newMuscleGroup: MuscleGroup = .Arms
    @State private var deleteConfirmedClicked = false
    @State private var showingDeleteMovementAlert = false
    @State private var showEditProgressView = false
    @State private var showDeleteProgressView = false
    
    @Binding var showDoneToolBar: Bool
    
    var muscleGroups: [MuscleGroup] = [.All, .Arms, .Back, .Chest, .Core, .Legs, .Shoulders]
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                
                VStack(spacing: 36) {
                    
                    Text("Edit Movement")
                        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Edit name")
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        MovementNameTextField(focus: false, movementName: $newMovementName, text: movementViewModel.movement.name)
                    }
                    .padding(.horizontal, 16)
                    
                    MovementTypePicker(movementTypeSelection: $newMovementType, captionText: "Edit movement type")
                        .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading,  spacing: 4) {
                        Text("Edit muscle group")
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
                            Task {
                                showDeleteProgressView = true
                                let result = await movementsViewModel.deleteMovement(docId: movementViewModel.movement.id)
                                handleEditMovementDissmiss(result: result, dismiss: dismiss, errorMessage: ErrorMessage.ErrorAddMovement.rawValue)
                            }
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        if showEditProgressView {
                            ProgressView()
                        } else {
                            UpdateMovementButton(updateMovementInFirebase: {
                                Task {
                                    showEditProgressView = true
                                    movementViewModel.movement.name = newMovementName
                                    movementViewModel.movement.movementType = newMovementType
                                    movementViewModel.movement.muscleGroup = newMuscleGroup
                                    let result = await movementViewModel.updateMovement()
                                    dismiss()
                                    handleEditMovementDissmiss(result: result, dismiss: dismiss, errorMessage: ErrorMessage.ErrorAddMovement.rawValue)
                                }
                            })
                        }
                    }
                })
            }
            .onAppear {
                newMovementName = movementViewModel.movement.name
                newMovementType = movementViewModel.movement.movementType
                newMuscleGroup = movementViewModel.movement.muscleGroup
            }
            .onDisappear {
                showDoneToolBar = true
            }
        }
    }
    
    func handleEditMovementDissmiss(result: FirebaseResult?, dismiss: DismissAction, errorMessage: String) {
        guard let result = result else { return }
        switch result {
        case .success:
            dismiss()
        case .failure(_):
            print(errorMessage)
        }
    }
}
