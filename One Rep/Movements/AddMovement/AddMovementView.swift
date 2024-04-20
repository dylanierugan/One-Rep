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
    
    @EnvironmentObject var theme: ThemeModel
    
    @State private var movementName = ""
    @State private var muscleGroup = Muscles.Arms.description
    var muscles = [Muscles.Arms.description, Muscles.Back.description, Muscles.Chest.description, Muscles.Core.description, Muscles.Legs.description, Muscles.Shoulders.description]
    private var isFormValid: Bool {
        !movementName.isEmpty
    }
    
    func addMovementToRealm() {
        let newMovement = Movement(name: movementName, muscleGroup: muscleGroup, logs: List<Log>())
        $movementModel.movements.append(newMovement)
    }
    
    var body: some View {
        ZStack {
            Color(theme.BackgroundColor)
                .ignoresSafeArea()
        
            VStack(spacing: 36) {
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Movement Name")
                        .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                        .foregroundColor(.secondary)
                    MovementNameTextField(text: "", movementName: $movementName, focus: true)
                }
                .padding(.horizontal, 16)
                
                VStack(alignment: .leading,  spacing: 4) {
                    Text("Muscle Group")
                        .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                        .foregroundColor(.secondary)
                    MusclePicker(muscles: muscles, muscleGroup: $muscleGroup)
                }
                .padding(.horizontal, 16)
                
                AddMovementButton(isFormValid: isFormValid, addMovementToRealm: { self.addMovementToRealm() })
            }
        }
    }
}
