//
//  AddMovementView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import SwiftUI
import RealmSwift

struct AddMovementView: View {
    
    @ObservedRealmObject var movement: Movement = Movement()
    @ObservedRealmObject var movementModel: MovementViewModel
    
    @State private var movementName = ""
    @State private var muscleGroup = Muscles.Arms.description
    var muscles = [Muscles.Arms.description, Muscles.Back.description, Muscles.Chest.description, Muscles.Core.description, Muscles.Legs.description, Muscles.Shoulders.description]
    private var isFormValid: Bool {
        !movementName.isEmpty
    }
    
    func addMovementToRealm() {
        let newMovement = Movement(name: movementName, muscleGroup: muscleGroup, weights: List<Weight>())
        $movementModel.movements.append(newMovement)
    }
    
    var body: some View {
        VStack(spacing: 36) {
            
            /// Movement name textfield
            VStack(alignment: .leading, spacing: 4) {
                Text("Movement Name")
                    .font(.caption.weight(.regular))
                    .foregroundColor(.secondary)
                MovementNameTextField(text: "", binding: $movementName, focus: true)
            }
            .padding(.horizontal, 16)
            
            /// Muscle group picker wheel
            VStack(alignment: .leading,  spacing: 4) {
                Text("Muscle Group")
                    .font(.caption.weight(.regular))
                    .foregroundColor(.secondary)
                MusclePicker(muscles: muscles, muscleGroup: $muscleGroup)
            }
            .padding(.horizontal, 16)
            
            /// Add movement button
            AddMovementButton(isFormValid: isFormValid, addMovementToRealm: { self.addMovementToRealm() })
            
        }
    }
}
