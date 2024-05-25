//
//  AddMovementView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import SwiftUI
import RealmSwift

struct AddMovementView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    
    @ObservedRealmObject var movementViewModel: MovementViewModel
    
    @State private var movementName = ""
    @State private var muscleGroup: MuscleType = .Arms
    
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
                        Text("Movement Name")
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        MovementNameTextField(focus: true, movementName: $movementName, text: "")
                    }
                    .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading,  spacing: 4) {
                        Text("Muscle Group")
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        MusclePicker(muscleGroup: $muscleGroup)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 24)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        AddMovementButton(isFormValid: isFormValid, addMovementToRealm: { self.addMovementToRealm() })
                    }
                }
            }
        }
    }
    
    // MARK: - Functions
    
    private func addMovementToRealm() {
        let newMovement = Movement(name: movementName, muscleGroup: muscleGroup, logs: List<Log>(), routine: "", mutatingValue: 5)
        $movementViewModel.movements.append(newMovement)
    }
}
