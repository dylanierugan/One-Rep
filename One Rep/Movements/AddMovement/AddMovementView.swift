//
//  AddMovementView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import SwiftUI

struct AddMovementView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var movementName = ""
    @State private var muscleGroup: MuscleGroup = .Arms
    @State private var movementType: MovementType = .Weight
    @State private var showProgressView = false
    
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
                    
                    Text("New Movement")
                        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Movement name")
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        MovementNameTextField(focus: true, movementName: $movementName, text: "")
                    }
                    .padding(.horizontal, 16)
                    
                    MovementTypePicker(movementTypeSelection: $movementType, captionText: "Movement type")
                        .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading,  spacing: 4) {
                        Text("Muscle group")
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
                                let docId = UUID().uuidString
                                let newMovement = Movement(id: docId, userId: movementsViewModel.userId, name: movementName, muscleGroup: muscleGroup, movementType: movementType, timeAdded: Date.now.timeIntervalSince1970, isPremium: false, mutatingValue: 5.0)
                                Task {
                                    showProgressView = true
                                    let result = await movementsViewModel.addMovement(movement: newMovement)
                                    showProgressView = false
                                    handleResultDismiss(result: result, dismiss: dismiss, errorMessage: ErrorMessage.ErrorAddMovement.rawValue)
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
    func handleResultDismiss(result: FirebaseResult?, dismiss: DismissAction, errorMessage: String) {
        guard let result = result else { return }
        switch result {
        case .success:
            dismiss()
        case .failure(_):
            print(errorMessage)
        }
    }
    
}
